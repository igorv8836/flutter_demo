// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'air_quality_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AirQualityResponse _$AirQualityResponseFromJson(Map<String, dynamic> json) =>
    AirQualityResponse(
      hourly: json['hourly'] == null
          ? null
          : AirQualityHourly.fromJson(json['hourly'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AirQualityResponseToJson(AirQualityResponse instance) =>
    <String, dynamic>{'hourly': instance.hourly};

AirQualityHourly _$AirQualityHourlyFromJson(Map<String, dynamic> json) =>
    AirQualityHourly(
      time: (json['time'] as List<dynamic>?)?.map((e) => e as String).toList(),
      pm25: (json['pm2_5'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
      pm10: (json['pm10'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
      usAqi: (json['us_aqi'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$AirQualityHourlyToJson(AirQualityHourly instance) =>
    <String, dynamic>{
      'time': instance.time,
      'pm2_5': instance.pm25,
      'pm10': instance.pm10,
      'us_aqi': instance.usAqi,
    };
