import '../core/model/settings.dart';

abstract class SettingsDataSource {
  Settings readSettings();
  void writeSettings(Settings settings);
}
