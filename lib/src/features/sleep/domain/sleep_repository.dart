import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../data/sleep_local_data_source.dart';
import '../model/awakening.dart';
import '../model/sleep_session.dart';

class SleepRepository {
  var version = 0;
  final SleepLocalDataSource _local;
  final List<SleepSession> _sessions = [];
  final Uuid _uuid = const Uuid();
  String? _activeSessionId;

  SleepRepository(this._local) {
    _sessions.addAll(_local.readSessions());
    final active = _sessions.where((s) => s.end == null).toList();
    _activeSessionId = active.isEmpty ? null : active.last.id;
  }

  List<SleepSession> get sessions => List.unmodifiable(_sessions);
  String? get activeSessionId => _activeSessionId;

  List<SleepSession> sessionsForDate(DateTime date) {
    final sameDay = _sessions.where((s) =>
            s.start.year == date.year &&
            s.start.month == date.month &&
            s.start.day == date.day)
        .toList();
    sameDay.sort((a, b) => b.start.compareTo(a.start));
    return sameDay;
  }

  SleepSession? getById(String id) {
    try {
      return _sessions.firstWhere((s) => s.id == id);
    } catch (_) {
      return null;
    }
  }

  SleepSession startSession() {
    version++;
    final session = SleepSession(id: _uuid.v4(), start: DateTime.now());
    _sessions.add(session);
    _activeSessionId = session.id;
    _persist();
    return session;
  }

  void finishActive() {
    if (_activeSessionId == null) return;
    final idx = _sessions.indexWhere((s) => s.id == _activeSessionId);
    if (idx == -1) return;
    _sessions[idx] = _sessions[idx].copyWith(end: DateTime.now());
    _activeSessionId = null;
    _persist();
  }

  void toggleAwakening() {
    if (_activeSessionId == null) return;
    final idx = _sessions.indexWhere((s) => s.id == _activeSessionId);
    if (idx == -1) return;
    final current = _sessions[idx];
    if (current.awakenings.isNotEmpty && current.awakenings.last.end == null) {
      final awakenings = [...current.awakenings];
      final last = awakenings.last.copyWith(end: DateTime.now());
      awakenings[awakenings.length - 1] = last;
      _sessions[idx] = current.copyWith(awakenings: awakenings);
    } else {
      final awakenings = [...current.awakenings, Awakening(start: DateTime.now())];
      _sessions[idx] = current.copyWith(awakenings: awakenings);
    }
    _persist();
  }

  void saveSession(SleepSession session) {
    final idx = _sessions.indexWhere((s) => s.id == session.id);
    if (idx == -1) return;
    final wasActive = _sessions[idx].end == null;
    _sessions[idx] = session;
    if (wasActive && session.end != null) {
      _activeSessionId = null;
    }
    _persist();
  }

  SleepSession? deleteSession(String id) {
    final idx = _sessions.indexWhere((s) => s.id == id);
    if (idx == -1) return null;
    final removed = _sessions.removeAt(idx);
    if (_activeSessionId == id) {
      _activeSessionId = null;
    }
    _persist();
    return removed;
  }

  void insertSession(SleepSession session, {int? index}) {
    if (index != null && index >= 0 && index <= _sessions.length) {
      _sessions.insert(index, session);
    } else {
      _sessions.add(session);
    }
    if (session.end == null) {
      _activeSessionId = session.id;
    }
    _persist();
  }

  void _persist() {
    _local.writeSessions(_sessions);
    version = version + 1;
  }
}
