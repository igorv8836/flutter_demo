import 'package:flutter/material.dart';

import '../model/sleep_schedule.dart';

class ScheduleLocalDataSource {
  final List<SleepSchedule> _storage = [];

  List<SleepSchedule> read() => List.unmodifiable(_storage);

  void write(List<SleepSchedule> days) {
    _storage
      ..clear()
      ..addAll(days);
  }

  bool get isEmpty => _storage.isEmpty;

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
