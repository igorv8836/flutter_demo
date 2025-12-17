import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'dto/air_quality_response.dart';
import 'dto/geocoding_response.dart';
import 'dto/hourly_forecast_response.dart';
import 'dto/sun_cycle_response.dart';

part 'open_meteo_api.g.dart';

@RestApi(baseUrl: 'https://api.open-meteo.com/')
abstract class OpenMeteoApi {
  factory OpenMeteoApi(Dio dio, {String baseUrl}) = _OpenMeteoApi;

  @GET('https://air-quality-api.open-meteo.com/v1/air-quality')
  Future<AirQualityResponse> airQuality({
    @Query('latitude') required double latitude,
    @Query('longitude') required double longitude,
    @Query('hourly') String hourly = 'pm2_5,pm10,us_aqi',
    @Query('timezone') String timezone = 'auto',
  });




  @GET('https://geocoding-api.open-meteo.com/v1/search')
  Future<GeocodingResponse> searchCity({
    @Query('name') required String name,
    @Query('count') int count = 1,
    @Query('language') String language = 'ru',
    @Query('format') String format = 'json',
  });

  @GET('/v1/forecast')
  Future<HourlyForecastResponse> hourlyForecast({
    @Query('latitude') required double latitude,
    @Query('longitude') required double longitude,
    @Query('hourly') String hourly = 'temperature_2m,precipitation,cloud_cover',
    @Query('timezone') String timezone = 'auto',
  });

  @GET('/v1/forecast')
  Future<SunCycleResponse> sunCycle({
    @Query('latitude') required double latitude,
    @Query('longitude') required double longitude,
    @Query('daily') String daily = 'sunrise,sunset',
    @Query('timezone') String timezone = 'auto',
  });

  @GET('https://air-quality-api.open-meteo.com/v1/air-quality')
  Future<AirQualityResponse> airQuality({
    @Query('latitude') required double latitude,
    @Query('longitude') required double longitude,
    @Query('hourly') String hourly = 'pm2_5,pm10,us_aqi',
    @Query('timezone') String timezone = 'auto',
  });
}
