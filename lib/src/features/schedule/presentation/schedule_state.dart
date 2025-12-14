import '../core/model/sleep_schedule.dart';

class ScheduleState {
  final List<SleepSchedule> days;

  const ScheduleState({required this.days});

  ScheduleState copyWith({List<SleepSchedule>? days}) => ScheduleState(days: days ?? this.days);
}
