import '../core/model/air_quality.dart';
import '../core/model/hourly_forecast.dart';
import '../core/model/location_point.dart';
import '../core/model/sun_cycle.dart';

abstract class WeatherRepository {
  Future<LocationPoint?> searchCity(String name);
  Future<HourlyForecast> loadHourly(LocationPoint point);
  Future<SunCycle?> loadSunCycle(LocationPoint point);
  Future<AirQuality?> loadAirQuality(LocationPoint point);
}
