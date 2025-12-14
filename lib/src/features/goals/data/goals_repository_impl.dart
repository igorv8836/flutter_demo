import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/goals_repository.dart';
import '../core/model/sleep_goal.dart';
import 'goals_data_source.dart';
import 'goals_local_data_source.dart';

final goalsRepositoryProvider = Provider<GoalsRepository>((ref) {
  return GoalsRepositoryImpl();
});

class GoalsRepositoryImpl implements GoalsRepository {
  GoalsRepositoryImpl({GoalsDataSource? dataSource}) : _local = dataSource ?? GoalsLocalDataSource();

  final GoalsDataSource _local;

  @override
  List<SleepGoal> readCustomGoals() => _local.readCustomGoals();

  @override
  void writeCustomGoals(List<SleepGoal> goals) => _local.writeCustomGoals(goals);
}
