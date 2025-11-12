import 'package:flutter/material.dart';

import 'app.dart';
import 'features/password/data/password_local_data_source.dart';
import 'features/password/domain/password_repository.dart';
import 'features/settings/data/settings_local_data_source.dart';
import 'features/settings/domain/settings_repository.dart';
import 'features/sleep/data/sleep_local_data_source.dart';
import 'features/sleep/domain/sleep_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final passwordRepository = PasswordRepository(PasswordLocalDataSource());
  final settingsRepository = SettingsRepository(SettingsLocalDataSource());
  final sleepRepository = SleepRepository(SleepLocalDataSource());

  runApp(
      SleepApp(
        passwordRepository: passwordRepository,
        sleepRepository: sleepRepository,
        settingsRepository: settingsRepository,
      )
  );
}
