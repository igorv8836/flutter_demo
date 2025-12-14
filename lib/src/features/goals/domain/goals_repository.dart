import '../core/model/sleep_goal.dart';

abstract class GoalsRepository {
  List<SleepGoal> readCustomGoals();
  void writeCustomGoals(List<SleepGoal> goals);
}
