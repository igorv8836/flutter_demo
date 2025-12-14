import '../core/model/settings.dart';

abstract class SettingsRepository {
  Settings readSettings();
  void writeSettings(Settings settings);
}
