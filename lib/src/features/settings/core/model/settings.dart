import 'package:flutter/material.dart';

class Settings {
  final Duration targetDuration;
  final TimeOfDay targetBedtime;
  final bool useDarkTheme;
  final String city;
  final double? latitude;
  final double? longitude;
  final bool useEnglishQuotes;
  const Settings({
    this.targetDuration = const Duration(hours: 8),
    this.targetBedtime = const TimeOfDay(hour: 23, minute: 0),
    this.useDarkTheme = false,
    this.city = '',
    this.latitude,
    this.longitude,
    this.useEnglishQuotes = false,
  });
  Settings copyWith({
    Duration? targetDuration,
    TimeOfDay? targetBedtime,
    bool? useDarkTheme,
    String? city,
    double? latitude,
    double? longitude,
    bool? useEnglishQuotes,
  }) =>
      Settings(
        targetDuration: targetDuration ?? this.targetDuration,
        targetBedtime: targetBedtime ?? this.targetBedtime,
        useDarkTheme: useDarkTheme ?? this.useDarkTheme,
        city: city ?? this.city,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        useEnglishQuotes: useEnglishQuotes ?? this.useEnglishQuotes,
      );
}
