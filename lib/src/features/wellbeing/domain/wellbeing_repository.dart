import 'wellbeing_state.dart';

abstract class WellbeingRepository {
  WellbeingState read();
  void write(WellbeingState state);
}
