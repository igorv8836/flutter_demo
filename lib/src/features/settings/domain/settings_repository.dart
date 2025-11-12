import 'package:flutter/foundation.dart';

import '../data/settings_local_data_source.dart';
import '../model/settings.dart';

class SettingsRepository {
  var version = 0;
  final SettingsLocalDataSource _local;

  SettingsRepository(this._local);

  Settings get settings => _local.readSettings();

  void update(Settings settings) {
    _local.writeSettings(settings);
    version = version + 1;
  }
}
