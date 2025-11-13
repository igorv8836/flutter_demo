import 'package:get_it/get_it.dart';

import '../../features/password/data/password_local_data_source.dart';
import '../../features/password/domain/password_repository.dart';
import '../../features/settings/data/settings_local_data_source.dart';
import '../../features/settings/domain/settings_repository.dart';
import '../../features/sleep/data/sleep_local_data_source.dart';
import '../../features/sleep/domain/sleep_repository.dart';

final getIt = GetIt.instance;

void setupLocator() {
  if (getIt.isRegistered<PasswordRepository>()) return;

  getIt
    ..registerLazySingleton<PasswordLocalDataSource>(() => PasswordLocalDataSource())
    ..registerLazySingleton<PasswordRepository>(() => PasswordRepository(getIt()))
    ..registerLazySingleton<SettingsLocalDataSource>(() => SettingsLocalDataSource())
    ..registerLazySingleton<SettingsRepository>(() => SettingsRepository(getIt()))
    ..registerLazySingleton<SleepLocalDataSource>(() => SleepLocalDataSource())
    ..registerLazySingleton<SleepRepository>(() => SleepRepository(getIt()));
}
