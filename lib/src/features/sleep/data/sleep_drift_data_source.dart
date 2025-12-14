import 'dart:async';

import '../core/model/sleep_session.dart';
import 'sleep_data_source.dart';
import 'sleep_database.dart';

class DriftSleepDataSource implements SleepDataSource {
  DriftSleepDataSource(this._db, List<SleepSession> cache) : _cache = List<SleepSession>.from(cache);

  final SleepDatabase _db;
  final List<SleepSession> _cache;

  static Future<DriftSleepDataSource> create(SleepDatabase db) async {
    final sessions = await db.loadSessions();
    return DriftSleepDataSource(db, sessions);
  }

  @override
  List<SleepSession> readSessions() => List.unmodifiable(_cache);

  @override
  void writeSessions(List<SleepSession> sessions) {
    _cache
      ..clear()
      ..addAll(sessions);
    unawaited(_db.replaceAllSessions(sessions));
  }
}
