import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/model/sleep_schedule.dart';
import 'schedule_data_source.dart';

class ScheduleLocalDataSource implements ScheduleDataSource {
  ScheduleLocalDataSource(this._prefs) : _storage = _loadFromPrefs(_prefs);

  final SharedPreferences _prefs;
  final List<SleepSchedule> _storage;

  static const _storageKey = 'schedule_days_v1';

  @override
  List<SleepSchedule> read() => List.unmodifiable(_storage);

  @override
  void write(List<SleepSchedule> days) {
    _storage
      ..clear()
      ..addAll(days);
    _persist();
  }

  @override
  bool get isEmpty => _storage.isEmpty;

  @override
  void seedDefaults(TimeOfDay bedtime, TimeOfDay wakeup) {
    final defaults = List.generate(
      7,
      (i) => SleepSchedule(
        weekday: i + 1,
        enabled: true,
        bedtime: bedtime,
        wakeup: wakeup,
        windDown: 'Подготовка ко сну за 30 мин',
      ),
    );
    write(defaults);
  }

  static List<SleepSchedule> _loadFromPrefs(SharedPreferences prefs) {
    final jsonString = prefs.getString(_storageKey);
    if (jsonString == null || jsonString.isEmpty) return [];
    try {
      final decoded = jsonDecode(jsonString) as List<dynamic>;
      return decoded
          .map((item) => _fromMap(Map<String, dynamic>.from(item as Map)))
          .whereType<SleepSchedule>()
          .toList();
    } catch (_) {
      return [];
    }
  }

  void _persist() {
    final encoded = jsonEncode(_storage.map(_toMap).toList());
    unawaited(_prefs.setString(_storageKey, encoded));
  }
}

Map<String, dynamic> _toMap(SleepSchedule schedule) => {
      'weekday': schedule.weekday,
      'enabled': schedule.enabled,
      'bedtime': _encodeTime(schedule.bedtime),
      'wakeup': _encodeTime(schedule.wakeup),
      'windDown': schedule.windDown,
    };

SleepSchedule? _fromMap(Map<String, dynamic> map) {
  final weekday = map['weekday'] as int?;
  final enabled = map['enabled'] as bool? ?? true;
  final bedtimeMinutes = map['bedtime'] as int?;
  final wakeupMinutes = map['wakeup'] as int?;
  if (weekday == null || bedtimeMinutes == null || wakeupMinutes == null) return null;
  return SleepSchedule(
    weekday: weekday,
    enabled: enabled,
    bedtime: _decodeTime(bedtimeMinutes),
    wakeup: _decodeTime(wakeupMinutes),
    windDown: map['windDown'] as String?,
  );
}

int _encodeTime(TimeOfDay time) => time.hour * 60 + time.minute;

TimeOfDay _decodeTime(int minutes) {
  final h = minutes ~/ 60;
  final m = minutes % 60;
  return TimeOfDay(hour: h, minute: m);
}
