// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geocoding_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeocodingResponse _$GeocodingResponseFromJson(Map<String, dynamic> json) =>
    GeocodingResponse(
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => GeoResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GeocodingResponseToJson(GeocodingResponse instance) =>
    <String, dynamic>{'results': instance.results};

GeoResult _$GeoResultFromJson(Map<String, dynamic> json) => GeoResult(
  name: json['name'] as String,
  country: json['country'] as String?,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
);

Map<String, dynamic> _$GeoResultToJson(GeoResult instance) => <String, dynamic>{
  'name': instance.name,
  'country': instance.country,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
};
