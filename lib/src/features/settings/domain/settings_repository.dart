import 'package:flutter/foundation.dart';

import '../data/settings_local_data_source.dart';
import '../model/settings.dart';

class SettingsRepository extends ChangeNotifier {
  final SettingsLocalDataSource _local;
  Settings _settings;

  SettingsRepository(this._local) : _settings = _local.readSettings();

  Settings get settings => _settings;

  void update(Settings settings) {
    _settings = settings;
    _local.writeSettings(settings);
    notifyListeners();
  }
}
