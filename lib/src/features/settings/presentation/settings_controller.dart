import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/settings_repository_impl.dart';
import '../core/model/settings.dart';
import '../domain/settings_repository.dart';

part 'settings_controller.g.dart';

@Riverpod(keepAlive: true)
class SettingsController extends _$SettingsController {
  late final SettingsRepository _repository;

  @override
  Settings build() {
    _repository = ref.read(settingsRepositoryProvider);
    return _repository.readSettings();
  }

  void update(Settings settings) {
    _repository.writeSettings(settings);
    state = settings;
  }
}
