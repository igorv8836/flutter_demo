import '../core/model/settings.dart';
import 'settings_data_source.dart';

class SettingsLocalDataSource implements SettingsDataSource {
  Settings _settings = const Settings();

  @override
  Settings readSettings() => _settings;

  @override
  void writeSettings(Settings settings) {
    _settings = settings;
  }
}
