import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'features/auth/presentation/auth_controller.dart';
import 'features/auth/data/auth_local_data_source.dart';
import 'features/schedule/data/schedule_local_data_source.dart';
import 'features/schedule/data/schedule_repository_impl.dart';
import 'features/settings/data/settings_local_data_source.dart';
import 'features/settings/data/settings_repository_impl.dart';
import 'features/sleep/data/sleep_drift_data_source.dart';
import 'features/sleep/data/sleep_repository_impl.dart';
import 'features/sleep/data/sleep_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final secureStorage = const FlutterSecureStorage();
  final authDataSource = await AuthLocalDataSource.create(secureStorage);
  final settingsDataSource = SettingsLocalDataSource(prefs);
  final scheduleDataSource = ScheduleLocalDataSource(prefs);
  final sleepDatabase = SleepDatabase();
  final sleepDataSource = await DriftSleepDataSource.create(sleepDatabase);

  runApp(
    ProviderScope(
      overrides: [
        authDataSourceProvider.overrideWithValue(authDataSource),
        settingsRepositoryProvider.overrideWithValue(
          SettingsRepositoryImpl(dataSource: settingsDataSource),
        ),
        scheduleRepositoryProvider.overrideWithValue(
          ScheduleRepositoryImpl(dataSource: scheduleDataSource),
        ),
        sleepRepositoryProvider.overrideWithValue(
          SleepRepositoryImpl(dataSource: sleepDataSource),
        ),
      ],
      child: const SleepApp(),
    ),
  );
}
