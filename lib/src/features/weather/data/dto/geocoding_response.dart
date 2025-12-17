import 'package:json_annotation/json_annotation.dart';

part 'geocoding_response.g.dart';

@JsonSerializable()
class GeocodingResponse {
  final List<GeoResult>? results;

  GeocodingResponse({this.results});

  factory GeocodingResponse.fromJson(Map<String, dynamic> json) => _$GeocodingResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GeocodingResponseToJson(this);
}

@JsonSerializable()
class GeoResult {
  final String name;
  final String? country;
  final double latitude;
  final double longitude;

  GeoResult({
    required this.name,
    this.country,
    required this.latitude,
    required this.longitude,
  });

  factory GeoResult.fromJson(Map<String, dynamic> json) => _$GeoResultFromJson(json);
  Map<String, dynamic> toJson() => _$GeoResultToJson(this);
}
