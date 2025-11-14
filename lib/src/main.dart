import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:practice_2/src/features/password/domain/password_repository.dart';

import 'app.dart';
import 'features/password/data/password_local_data_source.dart';
import 'shared/di/locator.dart';

void main() {
  final passwordSource = PasswordLocalDataSource();
  GetIt.I.registerFactory(() => PasswordRepository(passwordSource), instanceName: 'password_repo');

  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const ProviderScope(child: SleepApp()));
}
