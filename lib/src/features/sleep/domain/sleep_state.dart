import '../model/sleep_session.dart';

class SleepState {
  final List<SleepSession> sessions;
  final String? activeSessionId;

  SleepState({
    required List<SleepSession> sessions,
    this.activeSessionId,
  }) : sessions = List.unmodifiable(sessions);

  SleepState copyWith({
    List<SleepSession>? sessions,
    String? activeSessionId,
  }) {
    return SleepState(
      sessions: sessions ?? this.sessions,
      activeSessionId: activeSessionId ?? this.activeSessionId,
    );
  }

  SleepSession? sessionById(String id) {
    for (final session in sessions) {
      if (session.id == id) return session;
    }
    return null;
  }

  List<SleepSession> sessionsForDate(DateTime date) {
    final sameDay = sessions
        .where(
          (s) => s.start.year == date.year && s.start.month == date.month && s.start.day == date.day,
        )
        .toList();
    sameDay.sort((a, b) => b.start.compareTo(a.start));
    return sameDay;
  }
}
