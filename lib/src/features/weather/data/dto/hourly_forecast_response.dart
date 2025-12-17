import 'package:json_annotation/json_annotation.dart';

part 'hourly_forecast_response.g.dart';

@JsonSerializable()
class HourlyForecastResponse {
  final HourlyBlock? hourly;
  HourlyForecastResponse({this.hourly});

  factory HourlyForecastResponse.fromJson(Map<String, dynamic> json) => _$HourlyForecastResponseFromJson(json);
  Map<String, dynamic> toJson() => _$HourlyForecastResponseToJson(this);
}

@JsonSerializable()
class HourlyBlock {
  final List<String>? time;
  @JsonKey(name: 'temperature_2m')
  final List<double>? temperature2m;
  final List<double>? precipitation;
  @JsonKey(name: 'cloud_cover')
  final List<int>? cloudCover;

  HourlyBlock({
    this.time,
    this.temperature2m,
    this.precipitation,
    this.cloudCover,
  });

  factory HourlyBlock.fromJson(Map<String, dynamic> json) => _$HourlyBlockFromJson(json);
  Map<String, dynamic> toJson() => _$HourlyBlockToJson(this);
}
