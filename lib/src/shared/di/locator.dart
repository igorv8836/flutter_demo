import 'package:get_it/get_it.dart';

import '../../features/password/data/password_data_source.dart';
import '../../features/password/data/password_local_data_source.dart';
import '../../features/password/domain/password_repository.dart';

final getIt = GetIt.instance;

void setupLocator() {
  if (getIt.isRegistered<PasswordRepository>()) return;

  getIt
    ..registerLazySingleton<PasswordDataSource>(() => PasswordLocalDataSource())
    ..registerLazySingleton<PasswordRepository>(() => PasswordRepository(dataSource: getIt()));
}
