import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'settings_controller.dart';

part 'settings_form.g.dart';

class SettingsFormState {
  final Duration targetDuration;
  final TimeOfDay targetBedtime;
  final bool useDarkTheme;
  final String city;
  final bool useEnglishQuotes;

  const SettingsFormState({
    required this.targetDuration,
    required this.targetBedtime,
    required this.useDarkTheme,
    required this.city,
    required this.useEnglishQuotes,
  });

  SettingsFormState copyWith({
    Duration? targetDuration,
    TimeOfDay? targetBedtime,
    bool? useDarkTheme,
    String? city,
    bool? useEnglishQuotes,
  }) {
    return SettingsFormState(
      targetDuration: targetDuration ?? this.targetDuration,
      targetBedtime: targetBedtime ?? this.targetBedtime,
      useDarkTheme: useDarkTheme ?? this.useDarkTheme,
      city: city ?? this.city,
      useEnglishQuotes: useEnglishQuotes ?? this.useEnglishQuotes,
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
      city: current.city,
      useEnglishQuotes: current.useEnglishQuotes,
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
    final current = ref.read(settingsControllerProvider).copyWith(useDarkTheme: useDarkTheme);
    controller.update(current);
  }

  void updateCity(String city) {
    state = state.copyWith(city: city);
  }

  void updateUseEnglishQuotes(bool value) {
    state = state.copyWith(useEnglishQuotes: value);
  }

  void save() {
    final controller = ref.read(settingsControllerProvider.notifier);
    final current = ref.read(settingsControllerProvider);
    final updated = current.copyWith(
          targetDuration: state.targetDuration,
          targetBedtime: state.targetBedtime,
          useDarkTheme: state.useDarkTheme,
          city: state.city,
          latitude: current.latitude,
          longitude: current.longitude,
          useEnglishQuotes: state.useEnglishQuotes,
        );
    controller.update(updated);
  }
}
