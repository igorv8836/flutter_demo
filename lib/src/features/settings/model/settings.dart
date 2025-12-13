import 'package:flutter/material.dart';

class Settings {
  final Duration targetDuration;
  final TimeOfDay targetBedtime;
  final bool useDarkTheme;
  const Settings({
    this.targetDuration = const Duration(hours: 8),
    this.targetBedtime = const TimeOfDay(hour: 23, minute: 0),
    this.useDarkTheme = false,
  });
  Settings copyWith({Duration? targetDuration, TimeOfDay? targetBedtime, bool? useDarkTheme}) => Settings(
        targetDuration: targetDuration ?? this.targetDuration,
        targetBedtime: targetBedtime ?? this.targetBedtime,
        useDarkTheme: useDarkTheme ?? this.useDarkTheme,
      );
}
