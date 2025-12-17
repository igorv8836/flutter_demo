import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/network/dio_client.dart';
import '../core/model/air_quality.dart';
import '../core/model/hourly_forecast.dart';
import '../core/model/location_point.dart';
import '../core/model/sun_cycle.dart';
import '../domain/weather_repository.dart';
import 'dto/air_quality_response.dart';
import 'dto/geocoding_response.dart';
import 'dto/hourly_forecast_response.dart';
import 'dto/sun_cycle_response.dart';
import 'open_meteo_api.dart';

final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  final dio = createDio(baseUrl: 'https://api.open-meteo.com/');
  final api = OpenMeteoApi(dio);
  return WeatherRepositoryImpl(api);
});

class WeatherRepositoryImpl implements WeatherRepository {
  WeatherRepositoryImpl(this._api);

  final OpenMeteoApi _api;

  @override
  Future<AirQuality?> loadAirQuality(LocationPoint point) async {
    final resp = await _api.airQuality(latitude: point.latitude, longitude: point.longitude);
    return _mapAir(resp);
  }



  @override
  Future<LocationPoint?> searchCity(String name) async {
    try {
      final resp = await _api.searchCity(name: name);
      return _mapGeo(resp);
    } on DioException {
      return null;
    }
  }

  @override
  Future<HourlyForecast> loadHourly(LocationPoint point) async {
    final resp = await _api.hourlyForecast(latitude: point.latitude, longitude: point.longitude);
    return _mapHourly(resp);
  }

  @override
  Future<SunCycle?> loadSunCycle(LocationPoint point) async {
    final resp = await _api.sunCycle(latitude: point.latitude, longitude: point.longitude);
    return _mapSun(resp);
  }

  @override
  Future<AirQuality?> loadAirQuality(LocationPoint point) async {
    final resp = await _api.airQuality(latitude: point.latitude, longitude: point.longitude);
    return _mapAir(resp);
  }
}

LocationPoint? _mapGeo(GeocodingResponse response) {
  final first = response.results?.isNotEmpty == true ? response.results!.first : null;
  if (first == null) return null;
  final cityName = [first.name, first.country].whereType<String>().where((e) => e.isNotEmpty).join(', ');
  return LocationPoint(city: cityName.isEmpty ? first.name : cityName, latitude: first.latitude, longitude: first.longitude);
}

HourlyForecast _mapHourly(HourlyForecastResponse response) {
  final block = response.hourly;
  if (block == null || block.time == null || block.temperature2m == null) {
    return const HourlyForecast();
  }
  final now = DateTime.now();
  final points = <ForecastPoint>[];
  final times = block.time!;
  final temps = block.temperature2m!;
  final prec = block.precipitation ?? const [];
  final clouds = block.cloudCover ?? const [];
  for (var i = 0; i < times.length; i++) {
    final time = DateTime.tryParse(times[i]);
    if (time == null) continue;
    points.add(
      ForecastPoint(
        time: time,
        temperature: temps.length > i ? temps[i] : 0,
        precipitation: prec.length > i ? prec[i] : 0,
        cloudCover: clouds.length > i ? clouds[i] : 0,
      ),
    );
  }
  points.sort((a, b) => a.time.compareTo(b.time));
  final filtered = points.where((p) => p.time.isAfter(now.subtract(const Duration(hours: 1)))).take(12).toList();
  return HourlyForecast(points: filtered);
}

SunCycle? _mapSun(SunCycleResponse response) {
  final daily = response.daily;
  if (daily == null || daily.sunrise == null || daily.sunset == null || daily.sunrise!.isEmpty || daily.sunset!.isEmpty) {
    return null;
  }
  final sunrise = DateTime.tryParse(daily.sunrise!.first);
  final sunset = DateTime.tryParse(daily.sunset!.first);
  if (sunrise == null || sunset == null) return null;
  return SunCycle(sunrise: sunrise, sunset: sunset);
}

AirQuality? _mapAir(AirQualityResponse response) {
  final h = response.hourly;
  if (h == null || h.time == null || h.pm25 == null || h.pm10 == null) return null;
  if (h.time!.isEmpty || h.pm25!.isEmpty || h.pm10!.isEmpty) return null;
  final now = DateTime.now();
  AirQuality? candidate;
  for (var i = 0; i < h.time!.length; i++) {
    final time = DateTime.tryParse(h.time![i]);
    if (time == null) continue;
    final hasAqi = h.usAqi != null && h.usAqi!.length > i;
    final data = AirQuality(
      time: time,
      pm25: h.pm25!.length > i ? h.pm25![i] : 0,
      pm10: h.pm10!.length > i ? h.pm10![i] : 0,
      usAqi: hasAqi ? h.usAqi![i] : null,
    );
    if (time.isAfter(now) && candidate == null) {
      candidate = data;
      break;
    }
  }
  return candidate;
}
