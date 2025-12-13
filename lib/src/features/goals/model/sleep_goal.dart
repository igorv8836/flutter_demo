enum GoalType { duration, efficiency, regularity, awakenings, custom }

class SleepGoal {
  final String id;
  final String title;
  final String description;
  final GoalType type;
  final double progress; // 0..1
  final String metric;
  final bool isDone;

  const SleepGoal({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.progress,
    required this.metric,
    this.isDone = false,
  });

  SleepGoal copyWith({
    String? id,
    String? title,
    String? description,
    GoalType? type,
    double? progress,
    String? metric,
    bool? isDone,
  }) {
    return SleepGoal(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      progress: progress ?? this.progress,
      metric: metric ?? this.metric,
      isDone: isDone ?? this.isDone,
    );
  }
}
