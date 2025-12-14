import '../core/model/sleep_goal.dart';
import 'goals_data_source.dart';

class GoalsLocalDataSource implements GoalsDataSource {
  final List<SleepGoal> _customGoals = [];

  @override
  List<SleepGoal> readCustomGoals() => List.unmodifiable(_customGoals);

  @override
  void writeCustomGoals(List<SleepGoal> goals) {
    _customGoals
      ..clear()
      ..addAll(goals);
  }
}
