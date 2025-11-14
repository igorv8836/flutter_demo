import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../data/sleep_local_data_source.dart';
import '../model/awakening.dart';
import '../model/sleep_session.dart';
import 'sleep_state.dart';

part 'sleep_controller.g.dart';

@Riverpod(keepAlive: true)
class SleepController extends _$SleepController {
  late final SleepLocalDataSource _local;
  final Uuid _uuid = const Uuid();

  @override
  SleepState build() {
    _local = SleepLocalDataSource();
    return _initialState();
  }

  SleepState _initialState() {
    final stored = _local.readSessions();
    final sessions = List<SleepSession>.from(stored);
    String? activeId;
    for (final session in sessions) {
      if (session.end == null) {
        activeId = session.id;
      }
    }
    return SleepState(sessions: sessions, activeSessionId: activeId);
  }

  String? get activeSessionId => state.activeSessionId;

  List<SleepSession> sessionsForDate(DateTime date) => state.sessionsForDate(date);

  SleepSession? getById(String id) => state.sessionById(id);

  SleepSession startSession() {
    final session = SleepSession(id: _uuid.v4(), start: DateTime.now());
    final updated = [...state.sessions, session];
    _emit(state.copyWith(sessions: updated, activeSessionId: session.id));
    return session;
  }

  void finishActive() {
    final activeId = state.activeSessionId;
    if (activeId == null) return;
    final updated = state.sessions.map((s) {
      if (s.id != activeId) return s;
      return s.copyWith(end: DateTime.now());
    }).toList();
    _emit(state.copyWith(sessions: updated, activeSessionId: null));
  }

  void toggleAwakening() {
    final activeId = state.activeSessionId;
    if (activeId == null) return;
    final updated = state.sessions.map((s) {
      if (s.id != activeId) return s;
      final awakenings = [...s.awakenings];
      if (awakenings.isNotEmpty && awakenings.last.end == null) {
        final last = awakenings.removeLast();
        awakenings.add(last.copyWith(end: DateTime.now()));
      } else {
        awakenings.add(Awakening(start: DateTime.now()));
      }
      return s.copyWith(awakenings: awakenings);
    }).toList();
    _emit(state.copyWith(sessions: updated));
  }

  void saveSession(SleepSession session) {
    final idx = state.sessions.indexWhere((s) => s.id == session.id);
    if (idx == -1) return;
    final wasActive = state.sessions[idx].end == null;
    final updated = [...state.sessions];
    updated[idx] = session;
    final nextActive = wasActive && session.end != null ? null : state.activeSessionId;
    _emit(state.copyWith(sessions: updated, activeSessionId: nextActive));
  }

  SleepSession? deleteSession(String id) {
    final updated = [...state.sessions];
    final idx = updated.indexWhere((s) => s.id == id);
    if (idx == -1) return null;
    final removed = updated.removeAt(idx);
    final nextActive = state.activeSessionId == id ? null : state.activeSessionId;
    _emit(state.copyWith(sessions: updated, activeSessionId: nextActive));
    return removed;
  }

  void insertSession(SleepSession session, {int? index}) {
    final updated = [...state.sessions];
    if (index != null && index >= 0 && index <= updated.length) {
      updated.insert(index, session);
    } else {
      updated.add(session);
    }
    final activeId = session.end == null ? session.id : state.activeSessionId;
    _emit(state.copyWith(sessions: updated, activeSessionId: activeId));
  }

  void _emit(SleepState newState) {
    _local.writeSessions(newState.sessions);
    state = newState;
  }
}
