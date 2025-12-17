// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sun_cycle_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SunCycleResponse _$SunCycleResponseFromJson(Map<String, dynamic> json) =>
    SunCycleResponse(
      daily: json['daily'] == null
          ? null
          : DailyBlock.fromJson(json['daily'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SunCycleResponseToJson(SunCycleResponse instance) =>
    <String, dynamic>{'daily': instance.daily};

DailyBlock _$DailyBlockFromJson(Map<String, dynamic> json) => DailyBlock(
  sunrise: (json['sunrise'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  sunset: (json['sunset'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$DailyBlockToJson(DailyBlock instance) =>
    <String, dynamic>{'sunrise': instance.sunrise, 'sunset': instance.sunset};
