import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/sleep_controller.dart';
import '../model/sleep_session.dart';

part 'sleep_edit_form.g.dart';

class SleepEditFormState {
  final SleepSession? session;
  final DateTime? start;
  final DateTime? end;
  final SleepQuality? quality;
  final String note;

  const SleepEditFormState({
    this.session,
    this.start,
    this.end,
    this.quality,
    this.note = '',
  });

  bool get hasSession => session != null;
  bool get endBeforeStart => start != null && end != null && end!.isBefore(start!);

  SleepEditFormState copyWith({
    SleepSession? session,
    DateTime? start,
    DateTime? end,
    SleepQuality? quality,
    String? note,
  }) {
    return SleepEditFormState(
      session: session ?? this.session,
      start: start ?? this.start,
      end: end ?? this.end,
      quality: quality ?? this.quality,
      note: note ?? this.note,
    );
  }
}

@riverpod
class SleepEditForm extends _$SleepEditForm {
  late final TextEditingController _noteController;

  TextEditingController get noteController => _noteController;

  @override
  SleepEditFormState build(String sessionId) {
    _noteController = TextEditingController();
    ref.onDispose(() => _noteController.dispose());
    final session = ref.read(sleepControllerProvider).sessionById(sessionId);
    if (session == null) {
      return const SleepEditFormState();
    }
    final state = SleepEditFormState(
      session: session,
      start: session.start,
      end: session.end,
      quality: session.quality,
      note: session.note ?? '',
    );
    _noteController.text = state.note;
    return state;
  }

  void updateStart(DateTime value) {
    state = state.copyWith(start: value);
  }

  void updateEnd(DateTime? value) {
    state = state.copyWith(end: value);
  }

  void updateQuality(SleepQuality? value) {
    state = state.copyWith(quality: value);
  }

  void updateNote(String value) {
    state = state.copyWith(note: value);
  }

  String? save() {
    final session = state.session;
    final start = state.start;
    if (session == null || start == null) {
      return 'Сессия не найдена';
    }
    if (state.endBeforeStart) {
      return 'Окончание раньше начала';
    }
    final controller = ref.read(sleepControllerProvider.notifier);
    final updated = session.copyWith(
      start: start,
      end: state.end,
      quality: state.quality,
      note: state.note,
    );
    controller.saveSession(updated);
    state = state.copyWith(session: updated);
    return null;
  }
}
