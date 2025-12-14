import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/schedule_repository.dart';
import '../core/model/sleep_schedule.dart';
import 'schedule_data_source.dart';
import 'schedule_local_data_source.dart';

final scheduleRepositoryProvider = Provider<ScheduleRepository>((ref) {
  return ScheduleRepositoryImpl();
});

class ScheduleRepositoryImpl implements ScheduleRepository {
  ScheduleRepositoryImpl({ScheduleDataSource? dataSource}) : _local = dataSource ?? ScheduleLocalDataSource();

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
