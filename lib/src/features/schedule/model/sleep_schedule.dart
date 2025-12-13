import 'package:flutter/material.dart';

class SleepSchedule {
  final int weekday; // 1 (Mon) - 7 (Sun)
  final bool enabled;
  final TimeOfDay bedtime;
  final TimeOfDay wakeup;
  final String? windDown;

  const SleepSchedule({
    required this.weekday,
    required this.enabled,
    required this.bedtime,
    required this.wakeup,
    this.windDown,
  });

  SleepSchedule copyWith({
    int? weekday,
    bool? enabled,
    TimeOfDay? bedtime,
    TimeOfDay? wakeup,
    String? windDown,
  }) {
    return SleepSchedule(
      weekday: weekday ?? this.weekday,
      enabled: enabled ?? this.enabled,
      bedtime: bedtime ?? this.bedtime,
      wakeup: wakeup ?? this.wakeup,
      windDown: windDown ?? this.windDown,
    );
  }
}
