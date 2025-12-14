import '../core/model/sleep_session.dart';

abstract class SleepDataSource {
  List<SleepSession> readSessions();
  void writeSessions(List<SleepSession> sessions);
}
