import '../core/model/sleep_session.dart';
import 'sleep_data_source.dart';

class SleepLocalDataSource implements SleepDataSource {
  final List<SleepSession> _storage = [];

  @override
  List<SleepSession> readSessions() => List.unmodifiable(_storage);

  @override
  void writeSessions(List<SleepSession> sessions) {
    _storage
      ..clear()
      ..addAll(sessions);
  }
}
