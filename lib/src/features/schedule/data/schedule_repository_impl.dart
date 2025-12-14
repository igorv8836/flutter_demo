import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/schedule_repository.dart';
import '../core/model/sleep_schedule.dart';
import 'schedule_data_source.dart';

final scheduleRepositoryProvider = Provider<ScheduleRepository>((ref) {
  return ScheduleRepositoryImpl();
});

class ScheduleRepositoryImpl implements ScheduleRepository {
  ScheduleRepositoryImpl({ScheduleDataSource? dataSource}) : _local = dataSource ?? _InMemoryScheduleDataSource();

  final ScheduleDataSource _local;

  @override
  bool get isEmpty => _local.isEmpty;

  @override
  List<SleepSchedule> read() => _local.read();

  @override
  void seedDefaults(TimeOfDay bedtime, TimeOfDay wakeup) => _local.seedDefaults(bedtime, wakeup);

  @override
  void write(List<SleepSchedule> days) => _local.write(days);
}

class _InMemoryScheduleDataSource implements ScheduleDataSource {
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
