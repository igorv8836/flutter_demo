import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'sleep_controller.dart';
import '../core/model/sleep_session.dart';

part 'sleep_providers.g.dart';

@riverpod
class SleepSelectedDate extends _$SleepSelectedDate {
  @override
  DateTime build() => DateTime.now();

  void set(DateTime date) => state = date;
}

@riverpod
List<SleepSession> sleepSessions(Ref ref) {
  final date = ref.watch(sleepSelectedDateProvider);
  final state = ref.watch(sleepControllerProvider);
  return state.sessionsForDate(date);
}

@riverpod
SleepSession? sleepSession(Ref ref, String id) {
  final state = ref.watch(sleepControllerProvider);
  return state.sessionById(id);
}

@riverpod
Stream<Duration> sleepElapsed(Ref ref, String sessionId) async* {
  final session = ref.watch(sleepSessionProvider(sessionId));
  if (session == null) {
    yield Duration.zero;
    return;
  }
  while (true) {
    yield DateTime.now().difference(session.start);
    await Future.delayed(const Duration(seconds: 1));
  }
}
