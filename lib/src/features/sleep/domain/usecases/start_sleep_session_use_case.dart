import 'package:uuid/uuid.dart';

import '../../core/model/sleep_session.dart';
import '../sleep_state.dart';

class StartSleepSessionUseCase {
  StartSleepSessionUseCase({Uuid? uuid}) : _uuid = uuid ?? const Uuid();

  final Uuid _uuid;

  SleepState execute(SleepState state) {
    final session = SleepSession(id: _uuid.v4(), start: DateTime.now());
    final updated = [...state.sessions, session];
    return state.copyWith(sessions: updated, activeSessionId: session.id);
  }
}
