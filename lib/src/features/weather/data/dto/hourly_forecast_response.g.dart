// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hourly_forecast_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HourlyForecastResponse _$HourlyForecastResponseFromJson(
  Map<String, dynamic> json,
) => HourlyForecastResponse(
  hourly: json['hourly'] == null
      ? null
      : HourlyBlock.fromJson(json['hourly'] as Map<String, dynamic>),
);

Map<String, dynamic> _$HourlyForecastResponseToJson(
  HourlyForecastResponse instance,
) => <String, dynamic>{'hourly': instance.hourly};

HourlyBlock _$HourlyBlockFromJson(Map<String, dynamic> json) => HourlyBlock(
  time: (json['time'] as List<dynamic>?)?.map((e) => e as String).toList(),
  temperature2m: (json['temperature_2m'] as List<dynamic>?)
      ?.map((e) => (e as num).toDouble())
      .toList(),
  precipitation: (json['precipitation'] as List<dynamic>?)
      ?.map((e) => (e as num).toDouble())
      .toList(),
  cloudCover: (json['cloud_cover'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
);

Map<String, dynamic> _$HourlyBlockToJson(HourlyBlock instance) =>
    <String, dynamic>{
      'time': instance.time,
      'temperature_2m': instance.temperature2m,
      'precipitation': instance.precipitation,
      'cloud_cover': instance.cloudCover,
    };
