import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'settings_controller.dart';

part 'settings_form.g.dart';

class SettingsFormState {
  final Duration targetDuration;
  final TimeOfDay targetBedtime;
  final bool useDarkTheme;

  const SettingsFormState({
    required this.targetDuration,
    required this.targetBedtime,
    required this.useDarkTheme,
  });

  SettingsFormState copyWith({
    Duration? targetDuration,
    TimeOfDay? targetBedtime,
    bool? useDarkTheme,
  }) {
    return SettingsFormState(
      targetDuration: targetDuration ?? this.targetDuration,
      targetBedtime: targetBedtime ?? this.targetBedtime,
      useDarkTheme: useDarkTheme ?? this.useDarkTheme,
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
      useDarkTheme: current.useDarkTheme,
    );
  }

  void updateTarget(Duration duration) {
    state = state.copyWith(targetDuration: duration);
  }

  void updateBedtime(TimeOfDay bedtime) {
    state = state.copyWith(targetBedtime: bedtime);
  }

  void updateUseDarkTheme(bool useDarkTheme) {
    state = state.copyWith(useDarkTheme: useDarkTheme);
    // Сохраняем сразу, чтобы тема применилась немедленно
    final controller = ref.read(settingsControllerProvider.notifier);
    final current = ref.read(settingsControllerProvider);
    controller.update(current.copyWith(useDarkTheme: useDarkTheme));
  }

  void save() {
    final controller = ref.read(settingsControllerProvider.notifier);
    final updated = ref.read(settingsControllerProvider).copyWith(
          targetDuration: state.targetDuration,
          targetBedtime: state.targetBedtime,
          useDarkTheme: state.useDarkTheme,
        );
    controller.update(updated);
  }
}
