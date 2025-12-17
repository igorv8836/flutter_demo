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
  static const _cityKey = 'settings_city';
  static const _latKey = 'settings_lat';
  static const _lonKey = 'settings_lon';
  static const _quotesLangKey = 'settings_quotes_en';

  static Settings _loadFromPrefs(SharedPreferences prefs) {
    final durationMinutes = prefs.getInt(_durationKey);
    final bedtimeMinutes = prefs.getInt(_bedtimeKey);
    final useDark = prefs.getBool(_darkThemeKey);
    final city = prefs.getString(_cityKey) ?? '';
    final lat = prefs.getDouble(_latKey);
    final lon = prefs.getDouble(_lonKey);
    final useEnglishQuotes = prefs.getBool(_quotesLangKey) ?? false;
    return Settings(
      targetDuration: durationMinutes != null ? Duration(minutes: durationMinutes) : const Duration(hours: 8),
      targetBedtime: bedtimeMinutes != null ? _decodeTime(bedtimeMinutes) : const TimeOfDay(hour: 23, minute: 0),
      useDarkTheme: useDark ?? false,
      city: city,
      latitude: lat,
      longitude: lon,
      useEnglishQuotes: useEnglishQuotes,
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
    unawaited(_prefs.setString(_cityKey, settings.city));
    unawaited(_prefs.setBool(_quotesLangKey, settings.useEnglishQuotes));
    if (settings.latitude != null && settings.longitude != null) {
      unawaited(_prefs.setDouble(_latKey, settings.latitude!));
      unawaited(_prefs.setDouble(_lonKey, settings.longitude!));
    } else {
      unawaited(_prefs.remove(_latKey));
      unawaited(_prefs.remove(_lonKey));
    }
  }
}

int _encodeTime(TimeOfDay time) => time.hour * 60 + time.minute;

TimeOfDay _decodeTime(int totalMinutes) {
  final hour = totalMinutes ~/ 60;
  final minute = totalMinutes % 60;
  return TimeOfDay(hour: hour, minute: minute);
}
