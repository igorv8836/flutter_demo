import 'features/settings/model/settings.dart';
import 'features/sleep/model/sleep_session.dart';

class AppModel {
  Settings settings = const Settings();
  final List<SleepSession> sessions = [];
}