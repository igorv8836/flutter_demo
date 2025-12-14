import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/settings_repository.dart';
import '../core/model/settings.dart';
import 'settings_data_source.dart';

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepositoryImpl();
});

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl({SettingsDataSource? dataSource}) : _local = dataSource ?? _InMemorySettingsDataSource();

  final SettingsDataSource _local;

  @override
  Settings readSettings() => _local.readSettings();

  @override
  void writeSettings(Settings settings) => _local.writeSettings(settings);
}

class _InMemorySettingsDataSource implements SettingsDataSource {
  Settings _settings = const Settings();

  @override
  Settings readSettings() => _settings;

  @override
  void writeSettings(Settings settings) {
    _settings = settings;
  }
}
