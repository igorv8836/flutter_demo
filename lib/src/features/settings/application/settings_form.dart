import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/settings_controller.dart';

part 'settings_form.g.dart';

class SettingsFormState {
  final Duration targetDuration;
  final TimeOfDay targetBedtime;

  const SettingsFormState({
    required this.targetDuration,
    required this.targetBedtime,
  });

  SettingsFormState copyWith({
    Duration? targetDuration,
    TimeOfDay? targetBedtime,
  }) {
    return SettingsFormState(
      targetDuration: targetDuration ?? this.targetDuration,
      targetBedtime: targetBedtime ?? this.targetBedtime,
    );
  }
}

@riverpod
class SettingsForm extends _$SettingsForm {
  @override
  SettingsFormState build() {
    final current = ref.read(settingsControllerProvider);
    return SettingsFormState(
      targetDuration: current.targetDuration,
      targetBedtime: current.targetBedtime,
    );
  }

  void updateTarget(Duration duration) {
    state = state.copyWith(targetDuration: duration);
  }

  void updateBedtime(TimeOfDay bedtime) {
    state = state.copyWith(targetBedtime: bedtime);
  }

  void save() {
    final controller = ref.read(settingsControllerProvider.notifier);
    final updated = ref.read(settingsControllerProvider).copyWith(
          targetDuration: state.targetDuration,
          targetBedtime: state.targetBedtime,
        );
    controller.update(updated);
  }
}
