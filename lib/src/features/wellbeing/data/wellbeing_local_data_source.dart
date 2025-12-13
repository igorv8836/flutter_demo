import '../domain/wellbeing_state.dart';

class WellbeingLocalDataSource {
  WellbeingState _state = const WellbeingState();

  WellbeingState read() => _state;

  void write(WellbeingState state) {
    _state = state;
  }
}
