import '../model/sleep_session.dart';

class SleepLocalDataSource {
  final List<SleepSession> _storage = [];

  List<SleepSession> readSessions() => List.unmodifiable(_storage);

  void writeSessions(List<SleepSession> sessions) {
    _storage
      ..clear()
      ..addAll(sessions);
  }
}
