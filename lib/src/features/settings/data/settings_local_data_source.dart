import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/model/settings.dart';
import 'settings_data_source.dart';

class SettingsLocalDataSource implements SettingsDataSource {
  SettingsLocalDataSource(this._prefs) : _settings = _loadFromPrefs(_prefs);

  final SharedPreferences _prefs;
  Settings _settings;

  static const _durationKey = 'settings_duration_minutes';
  static const _bedtimeKey = 'settings_bedtime_minutes';
  static const _darkThemeKey = 'settings_dark_theme';

  static Settings _loadFromPrefs(SharedPreferences prefs) {
    final durationMinutes = prefs.getInt(_durationKey);
    final bedtimeMinutes = prefs.getInt(_bedtimeKey);
    final useDark = prefs.getBool(_darkThemeKey);
    return Settings(
      targetDuration: durationMinutes != null ? Duration(minutes: durationMinutes) : const Duration(hours: 8),
      targetBedtime: bedtimeMinutes != null ? _decodeTime(bedtimeMinutes) : const TimeOfDay(hour: 23, minute: 0),
      useDarkTheme: useDark ?? false,
    );
  }

  @override
  Settings readSettings() => _settings;

  @override
  void writeSettings(Settings settings) {
    _settings = settings;
    unawaited(_prefs.setInt(_durationKey, settings.targetDuration.inMinutes));
    unawaited(_prefs.setInt(_bedtimeKey, _encodeTime(settings.targetBedtime)));
    unawaited(_prefs.setBool(_darkThemeKey, settings.useDarkTheme));
  }
}

int _encodeTime(TimeOfDay time) => time.hour * 60 + time.minute;

TimeOfDay _decodeTime(int totalMinutes) {
  final hour = totalMinutes ~/ 60;
  final minute = totalMinutes % 60;
  return TimeOfDay(hour: hour, minute: minute);
}
