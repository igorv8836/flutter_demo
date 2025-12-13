import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../settings/domain/settings_controller.dart';
import '../../settings/model/settings.dart';
import '../../sleep/domain/sleep_controller.dart';
import '../../sleep/model/sleep_session.dart';
import '../../stats/stats_service.dart';
import '../../../shared/utils/format.dart';
import '../data/goals_local_data_source.dart';
import '../model/sleep_goal.dart';
import 'goals_state.dart';

part 'goals_controller.g.dart';

@Riverpod(keepAlive: true)
class GoalsController extends _$GoalsController {
  late final GoalsLocalDataSource _local;
  final Uuid _uuid = const Uuid();

  @override
  GoalsState build() {
    _local = GoalsLocalDataSource();
    final settings = ref.watch(settingsControllerProvider);
    final sessions = ref.watch(sleepControllerProvider).sessions;
    final computed = _buildComputedGoals(sessions, settings);
    final custom = _local.readCustomGoals();
    return GoalsState(computedGoals: computed, customGoals: custom);
  }

  void addCustomGoal(String title, {String description = ''}) {
    final goal = SleepGoal(
      id: _uuid.v4(),
      title: title.isEmpty ? 'Новая цель' : title,
      description: description.isEmpty ? 'Пользовательская цель' : description,
      type: GoalType.custom,
      progress: 0,
      metric: '0% готово',
      isDone: false,
    );
    final updated = [...state.customGoals, goal];
    _local.writeCustomGoals(updated);
    state = state.copyWith(customGoals: updated);
  }

  void updateCustomProgress(String id, double progress) {
    final updated = state.customGoals.map((g) {
      if (g.id != id) return g;
      final clamped = progress.clamp(0.0, 1.0);
      return g.copyWith(
        progress: clamped,
        metric: '${(clamped * 100).round()}% готово',
        isDone: clamped >= 0.99,
      );
    }).toList();
    _local.writeCustomGoals(updated);
    state = state.copyWith(customGoals: updated);
  }

  void toggleCustomDone(String id) {
    final updated = state.customGoals.map((g) {
      if (g.id != id) return g;
      final nextDone = !g.isDone;
      return g.copyWith(
        isDone: nextDone,
        progress: nextDone ? 1.0 : 0.5,
        metric: nextDone ? '100% готово' : '50% готово',
      );
    }).toList();
    _local.writeCustomGoals(updated);
    state = state.copyWith(customGoals: updated);
  }

  void deleteCustomGoal(String id) {
    final updated = state.customGoals.where((g) => g.id != id).toList();
    _local.writeCustomGoals(updated);
    state = state.copyWith(customGoals: updated);
  }

  void refreshComputed() {
    final settings = ref.read(settingsControllerProvider);
    final sessions = ref.read(sleepControllerProvider).sessions;
    state = state.copyWith(computedGoals: _buildComputedGoals(sessions, settings));
  }

  List<SleepGoal> _buildComputedGoals(List<SleepSession> sessions, Settings settings) {
    final stats = StatsService().compute(sessions, settings, days: 7);
    final avgAwakenings = _averageAwakenings(sessions, days: 7);

    final targets = <SleepGoal>[
      SleepGoal(
        id: 'goal-duration',
        title: 'Спать не менее ${fmtHm(settings.targetDuration)}',
        description: 'Средняя длительность сна за 7 дней',
        type: GoalType.duration,
        progress: _clamp(stats.avgDuration.inMinutes / settings.targetDuration.inMinutes.toDouble()),
        metric: '${fmtHm(stats.avgDuration)} / ${fmtHm(settings.targetDuration)}',
        isDone: stats.avgDuration >= settings.targetDuration,
      ),
      SleepGoal(
        id: 'goal-efficiency',
        title: 'Эффективность сна',
        description: 'Доля времени во сне без пробуждений',
        type: GoalType.efficiency,
        progress: _clamp(stats.efficiency),
        metric: '${(stats.efficiency * 100).round()}%',
        isDone: stats.efficiency >= 0.9,
      ),
      SleepGoal(
        id: 'goal-regularity',
        title: 'Регулярность отбоя',
        description: 'Разброс времени засыпания за неделю',
        type: GoalType.regularity,
        progress: _clamp(1 - stats.regularity.inMinutes / 120),
        metric: '${stats.regularity.inMinutes} мин разброс',
        isDone: stats.regularity.inMinutes <= 30,
      ),
    ];

    if (sessions.isNotEmpty) {
      targets.add(
        SleepGoal(
          id: 'goal-awakenings',
          title: 'Меньше пробуждений',
          description: 'Среднее число пробуждений за сессию',
          type: GoalType.awakenings,
          progress: _clamp(1 - avgAwakenings / 3),
          metric: '${avgAwakenings.toStringAsFixed(1)} в среднем',
          isDone: avgAwakenings <= 1,
        ),
      );
    }

    return targets;
  }

  double _averageAwakenings(List<SleepSession> sessions, {int days = 7}) {
    final cutoff = DateTime.now().subtract(Duration(days: days));
    final recent = sessions.where((s) => s.end != null && s.end!.isAfter(cutoff)).toList();
    if (recent.isEmpty) return 0;
    final total = recent.fold<int>(0, (sum, s) => sum + s.awakenings.length);
    return total / recent.length;
  }
}

double _clamp(double v) => v < 0 ? 0 : (v > 1 ? 1 : v);
