import 'package:flutter/widgets.dart';

import '../../features/password/domain/password_repository.dart';
import '../../features/settings/domain/settings_repository.dart';
import '../../features/sleep/domain/sleep_repository.dart';

class AppScope extends InheritedWidget {
  final PasswordRepository passwordRepository;
  final SleepRepository sleepRepository;
  final SettingsRepository settingsRepository;

  const AppScope({
    super.key,
    required super.child,
    required this.passwordRepository,
    required this.sleepRepository,
    required this.settingsRepository,
  });

  static AppScope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'AppScope not found in context');
    return scope!;
  }

  @override
  bool updateShouldNotify(covariant AppScope oldWidget) {
    return passwordRepository.version != oldWidget.passwordRepository.version ||
        sleepRepository.version != oldWidget.sleepRepository.version ||
        settingsRepository.version != oldWidget.settingsRepository.version;
  }
}
