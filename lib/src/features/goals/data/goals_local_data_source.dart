import '../model/sleep_goal.dart';

class GoalsLocalDataSource {
  final List<SleepGoal> _customGoals = [];

  List<SleepGoal> readCustomGoals() => List.unmodifiable(_customGoals);

  void writeCustomGoals(List<SleepGoal> goals) {
    _customGoals
      ..clear()
      ..addAll(goals);
  }
}
