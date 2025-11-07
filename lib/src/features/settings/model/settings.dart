import 'package:flutter/material.dart';

class Settings {
  final Duration targetDuration;
  final TimeOfDay targetBedtime;
  const Settings({this.targetDuration = const Duration(hours: 8), this.targetBedtime = const TimeOfDay(hour: 23, minute: 0)});
  Settings copyWith({Duration? targetDuration, TimeOfDay? targetBedtime}) => Settings(
    targetDuration: targetDuration ?? this.targetDuration,
    targetBedtime: targetBedtime ?? this.targetBedtime,
  );
}