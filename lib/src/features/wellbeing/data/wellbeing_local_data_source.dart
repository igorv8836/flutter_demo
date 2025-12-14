import '../domain/wellbeing_state.dart';
import 'wellbeing_data_source.dart';

class WellbeingLocalDataSource implements WellbeingDataSource {
  WellbeingState _state = const WellbeingState();

  @override
  WellbeingState read() => _state;

  @override
  void write(WellbeingState state) {
    _state = state;
  }
}
