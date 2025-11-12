import '../model/settings.dart';

class SettingsLocalDataSource {
  Settings _settings = const Settings();

  Settings readSettings() => _settings;

  void writeSettings(Settings settings) {
    _settings = settings;
  }
}
