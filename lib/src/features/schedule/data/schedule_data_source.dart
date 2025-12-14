import 'package:flutter/material.dart';

import '../core/model/sleep_schedule.dart';

abstract class ScheduleDataSource {
  List<SleepSchedule> read();
  void write(List<SleepSchedule> days);
  bool get isEmpty;
  void seedDefaults(TimeOfDay bedtime, TimeOfDay wakeup);
}
