import '../core/model/sleep_session.dart';

abstract class SleepRepository {
  List<SleepSession> readSessions();
  void writeSessions(List<SleepSession> sessions);
}
