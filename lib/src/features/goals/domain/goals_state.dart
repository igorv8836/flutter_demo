import '../model/sleep_goal.dart';

class GoalsState {
  final List<SleepGoal> computedGoals;
  final List<SleepGoal> customGoals;

  const GoalsState({
    required this.computedGoals,
    required this.customGoals,
  });

  List<SleepGoal> get all => [...computedGoals, ...customGoals];

  GoalsState copyWith({
    List<SleepGoal>? computedGoals,
    List<SleepGoal>? customGoals,
  }) {
    return GoalsState(
      computedGoals: computedGoals ?? this.computedGoals,
      customGoals: customGoals ?? this.customGoals,
    );
  }
}
