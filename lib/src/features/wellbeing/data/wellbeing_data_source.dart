import '../domain/wellbeing_state.dart';

abstract class WellbeingDataSource {
  WellbeingState read();
  void write(WellbeingState state);
}
