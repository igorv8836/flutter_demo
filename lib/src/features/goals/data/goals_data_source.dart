import '../core/model/sleep_goal.dart';

abstract class GoalsDataSource {
  List<SleepGoal> readCustomGoals();
  void writeCustomGoals(List<SleepGoal> goals);
}
