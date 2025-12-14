import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../goals_controller.dart';
import '../../core/model/sleep_goal.dart';

class GoalsScreen extends ConsumerWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(goalsControllerProvider);
    final notifier = ref.read(goalsControllerProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Трекер целей'),
        leading: IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back)),
        actions: [
          IconButton(
            onPressed: notifier.refreshComputed,
            tooltip: 'Обновить данные',
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddGoal(context, notifier),
        label: const Text('Новая цель'),
        icon: const Icon(Icons.flag),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Цели по данным сна', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          if (state.computedGoals.isEmpty)
            const Text('Недостаточно данных, начните отслеживать сессии сна.'),
          ...state.computedGoals.map((g) => _GoalCard(goal: g)),
          const SizedBox(height: 16),
          const Text('Мои цели', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          if (state.customGoals.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Text('Добавьте собственную цель: например «ложиться до 23:30» или «без телефонов за час до сна».'),
              ),
            ),
          ...state.customGoals.map(
            (g) => _GoalCard(
              goal: g,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    tooltip: g.isDone ? 'Снять выполнение' : 'Отметить выполненным',
                    onPressed: () => notifier.toggleCustomDone(g.id),
                    icon: Icon(g.isDone ? Icons.check_circle : Icons.check_circle_outline),
                  ),
                  IconButton(
                    tooltip: 'Удалить',
                    onPressed: () => notifier.deleteCustomGoal(g.id),
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
              bottom: Slider(
                value: g.progress,
                onChanged: (v) => notifier.updateCustomProgress(g.id, v),
              ),
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Future<void> _showAddGoal(BuildContext context, GoalsController notifier) async {
    final title = TextEditingController();
    final desc = TextEditingController();
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: title, decoration: const InputDecoration(labelText: 'Название цели')),
              TextField(controller: desc, decoration: const InputDecoration(labelText: 'Описание')),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: () {
                  notifier.addCustomGoal(title.text, description: desc.text);
                  Navigator.of(ctx).pop();
                },
                child: const Text('Добавить'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _GoalCard extends StatelessWidget {
  final SleepGoal goal;
  final Widget? trailing;
  final Widget? bottom;
  const _GoalCard({required this.goal, this.trailing, this.bottom});

  Color _progressColor(BuildContext context) {
    if (goal.isDone) return Colors.green;
    if (goal.progress >= 0.7) return Colors.lightGreen;
    if (goal.progress >= 0.4) return Theme.of(context).colorScheme.primary;
    return Colors.orange;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(goal.title, style: const TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 4),
                      Text(goal.description, style: const TextStyle(color: Colors.black54)),
                    ],
                  ),
                ),
                if (trailing != null) trailing!,
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(value: goal.progress, minHeight: 10, color: _progressColor(context)),
            const SizedBox(height: 8),
            Text(goal.metric, style: const TextStyle(fontWeight: FontWeight.w500)),
            if (bottom != null) bottom!,
          ],
        ),
      ),
    );
  }
}
