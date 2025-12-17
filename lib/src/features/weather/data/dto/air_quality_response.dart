import 'package:json_annotation/json_annotation.dart';

part 'air_quality_response.g.dart';

@JsonSerializable()
class AirQualityResponse {
  final AirQualityHourly? hourly;

  AirQualityResponse({this.hourly});

  factory AirQualityResponse.fromJson(Map<String, dynamic> json) => _$AirQualityResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AirQualityResponseToJson(this);
}

@JsonSerializable()
class AirQualityHourly {
  final List<String>? time;
  @JsonKey(name: 'pm2_5')
  final List<double>? pm25;
  final List<double>? pm10;
  @JsonKey(name: 'us_aqi')
  final List<int>? usAqi;

  AirQualityHourly({this.time, this.pm25, this.pm10, this.usAqi});

  factory AirQualityHourly.fromJson(Map<String, dynamic> json) => _$AirQualityHourlyFromJson(json);
  Map<String, dynamic> toJson() => _$AirQualityHourlyToJson(this);
}
