import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/wellbeing_local_data_source.dart';
import 'wellbeing_state.dart';

final wellbeingControllerProvider = StateNotifierProvider<WellbeingController, WellbeingState>((ref) {
  return WellbeingController();
});

class WellbeingController extends StateNotifier<WellbeingState> {
  WellbeingController() : super(const WellbeingState()) {
    _local = WellbeingLocalDataSource();
    state = _local.read();
  }

  late final WellbeingLocalDataSource _local;

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
    _local.write(next);
  }
}
