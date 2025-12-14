import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/wellbeing_repository_impl.dart';
import '../domain/wellbeing_repository.dart';
import '../domain/wellbeing_state.dart';

final wellbeingControllerProvider = StateNotifierProvider<WellbeingController, WellbeingState>((ref) {
  return WellbeingController(ref);
});

class WellbeingController extends StateNotifier<WellbeingState> {
  WellbeingController(this._ref) : super(const WellbeingState()) {
    _repository = _ref.read(wellbeingRepositoryProvider);
    state = _repository.read();
  }

  late final WellbeingRepository _repository;
  final Ref _ref;

  void updateStress(double value) {
    final next = (value.clamp(0, 1)).toDouble();
    _setState(state.copyWith(stress: next));
  }

  void updateMood(double value) {
    final next = (value.clamp(0, 1)).toDouble();
    _setState(state.copyWith(mood: next));
  }

  void addWater(int ml) {
    _setState(state.copyWith(waterMl: state.waterMl + ml));
  }

  void reset() {
    _setState(const WellbeingState());
  }

  void saveNote(String note) {
    if (note.trim().isEmpty) return;
    _setState(state.copyWith(lastNote: note.trim()));
  }

  void startAction(Duration duration, String label) {
    final endsAt = DateTime.now().add(duration);
    _setState(state.copyWith(activeAction: label, actionEndsAt: endsAt));
  }

  void cancelAction() {
    _setState(state.copyWith(activeAction: null, actionEndsAt: null));
  }

  void _setState(WellbeingState next) {
    state = next;
    _repository.write(next);
  }
}
