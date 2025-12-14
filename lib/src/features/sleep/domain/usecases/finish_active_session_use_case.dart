import '../sleep_state.dart';

class FinishActiveSessionUseCase {
  SleepState execute(SleepState state) {
    final activeId = state.activeSessionId;
    if (activeId == null) return state;
    final updated = state.sessions.map((s) {
      if (s.id != activeId) return s;
      return s.copyWith(end: DateTime.now());
    }).toList();
    return state.copyWith(sessions: updated, activeSessionId: null);
  }
}
