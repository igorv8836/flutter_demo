import 'package:json_annotation/json_annotation.dart';

part 'sun_cycle_response.g.dart';

@JsonSerializable()
class SunCycleResponse {
  final DailyBlock? daily;

  SunCycleResponse({this.daily});

  factory SunCycleResponse.fromJson(Map<String, dynamic> json) => _$SunCycleResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SunCycleResponseToJson(this);
}

@JsonSerializable()
class DailyBlock {
  final List<String>? sunrise;
  final List<String>? sunset;

  DailyBlock({this.sunrise, this.sunset});

  factory DailyBlock.fromJson(Map<String, dynamic> json) => _$DailyBlockFromJson(json);
  Map<String, dynamic> toJson() => _$DailyBlockToJson(this);
}
