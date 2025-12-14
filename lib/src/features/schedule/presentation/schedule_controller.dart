import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../settings/presentation/settings_controller.dart';
import '../data/schedule_repository_impl.dart';
import '../core/model/sleep_schedule.dart';
import '../domain/schedule_repository.dart';
import 'schedule_state.dart';

part 'schedule_controller.g.dart';

@Riverpod(keepAlive: true)
class ScheduleController extends _$ScheduleController {
  late final ScheduleRepository _repository;

  @override
  ScheduleState build() {
    _repository = ref.read(scheduleRepositoryProvider);
    final settings = ref.watch(settingsControllerProvider);
    if (_repository.isEmpty) {
      final wake = _addDuration(settings.targetBedtime, settings.targetDuration);
      _repository.seedDefaults(settings.targetBedtime, wake);
    }
    return ScheduleState(days: _repository.read());
  }

  void updateBedtime(int weekday, TimeOfDay time) {
    final updated = state.days.map((d) => d.weekday == weekday ? d.copyWith(bedtime: time) : d).toList();
    _emit(updated);
  }

  void updateWakeup(int weekday, TimeOfDay time) {
    final updated = state.days.map((d) => d.weekday == weekday ? d.copyWith(wakeup: time) : d).toList();
    _emit(updated);
  }

  void toggleDay(int weekday, bool enabled) {
    final updated = state.days.map((d) => d.weekday == weekday ? d.copyWith(enabled: enabled) : d).toList();
    _emit(updated);
  }

  void updateWindDown(int weekday, String text) {
    final updated = state.days.map((d) => d.weekday == weekday ? d.copyWith(windDown: text) : d).toList();
    _emit(updated);
  }

  void applyToAll(TimeOfDay bedtime, TimeOfDay wakeup) {
    final updated = state.days.map((d) => d.copyWith(bedtime: bedtime, wakeup: wakeup)).toList();
    _emit(updated);
  }

  void syncWithSettings() {
    final settings = ref.read(settingsControllerProvider);
    final wake = _addDuration(settings.targetBedtime, settings.targetDuration);
    applyToAll(settings.targetBedtime, wake);
  }

  void _emit(List<SleepSchedule> days) {
    _repository.write(days);
    state = state.copyWith(days: days);
  }
}

TimeOfDay _addDuration(TimeOfDay base, Duration duration) {
  final totalMinutes = base.hour * 60 + base.minute + duration.inMinutes;
  final mod = totalMinutes % (24 * 60);
  final h = mod ~/ 60;
  final m = mod % 60;
  return TimeOfDay(hour: h, minute: m);
}
