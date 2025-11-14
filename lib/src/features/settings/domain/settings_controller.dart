import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/settings_local_data_source.dart';
import '../model/settings.dart';

part 'settings_controller.g.dart';

@Riverpod(keepAlive: true)
class SettingsController extends _$SettingsController {
  late final SettingsLocalDataSource _local;

  @override
  Settings build() {
    _local = SettingsLocalDataSource();
    return _local.readSettings();
  }

  void update(Settings settings) {
    _local.writeSettings(settings);
    state = settings;
  }
}
