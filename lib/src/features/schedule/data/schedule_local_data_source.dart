import 'package:flutter/material.dart';

import '../core/model/sleep_schedule.dart';
import 'schedule_data_source.dart';

class ScheduleLocalDataSource implements ScheduleDataSource {
  final List<SleepSchedule> _storage = [];

  @override
  List<SleepSchedule> read() => List.unmodifiable(_storage);

  @override
  void write(List<SleepSchedule> days) {
    _storage
      ..clear()
      ..addAll(days);
  }

  @override
  bool get isEmpty => _storage.isEmpty;

  @override
  void seedDefaults(TimeOfDay bedtime, TimeOfDay wakeup) {
    _storage
      ..clear()
      ..addAll(List.generate(
        7,
        (i) => SleepSchedule(
          weekday: i + 1,
          enabled: true,
          bedtime: bedtime,
          wakeup: wakeup,
          windDown: 'Подготовка ко сну за 30 мин',
        ),
      ));
  }
}
