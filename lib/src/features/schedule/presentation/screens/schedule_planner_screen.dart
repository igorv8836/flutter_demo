import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/utils/format.dart';
import '../schedule_controller.dart';
import '../../core/model/sleep_schedule.dart';
import '../../../weather/presentation/weather_controller.dart';

class SchedulePlannerScreen extends ConsumerWidget {
  const SchedulePlannerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scheduleControllerProvider);
    final notifier = ref.read(scheduleControllerProvider.notifier);
    final weather = ref.watch(weatherControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Планировщик режима'),
        leading: IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back)),
        actions: [
          IconButton(
            onPressed: notifier.syncWithSettings,
            tooltip: 'Подстроить под цели',
            icon: const Icon(Icons.auto_fix_high),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (weather.sunCycle != null)
            Card(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    const Icon(Icons.wb_twilight, size: 28),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Восход: ${fmtTime(weather.sunCycle!.sunrise)}'),
                          Text('Закат: ${fmtTime(weather.sunCycle!.sunset)}'),
                        ],
                      ),
                    ),
                    Text(
                      'Совет: ложитесь за 1-2 ч до заката для плавного засыпания',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          Card(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Скопировать на все дни', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: [
                      FilledButton.tonal(
                        onPressed: () {
                          if (state.days.isEmpty) return;
                          final first = state.days.first;
                          notifier.applyToAll(first.bedtime, first.wakeup);
                        },
                        child: const Text('Как по будням'),
                      ),
                      FilledButton.tonal(
                        onPressed: notifier.syncWithSettings,
                        child: const Text('Как в настройках'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          ...state.days.map(
            (d) => _ScheduleTile(
              day: d,
              onToggle: (value) => notifier.toggleDay(d.weekday, value),
              onPickBedtime: () => _pickTime(context, d.bedtime, (time) => notifier.updateBedtime(d.weekday, time)),
              onPickWake: () => _pickTime(context, d.wakeup, (time) => notifier.updateWakeup(d.weekday, time)),
              onEditWindDown: () => _editWindDown(context, notifier, d),
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Future<void> _pickTime(BuildContext context, TimeOfDay initial, void Function(TimeOfDay) onSelected) async {
    final result = await showTimePicker(context: context, initialTime: initial);
    if (result != null) onSelected(result);
  }

  Future<void> _editWindDown(BuildContext context, ScheduleController notifier, SleepSchedule day) async {
    final controller = TextEditingController(text: day.windDown ?? '');
    await showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Ритуал перед сном: ${weekdayName(day.weekday)}'),
          content: TextField(
            controller: controller,
            maxLines: 2,
            decoration: const InputDecoration(hintText: 'Например, «без экранов за 30 минут»'),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Отмена')),
            FilledButton(
              onPressed: () {
                notifier.updateWindDown(day.weekday, controller.text.trim());
                Navigator.of(ctx).pop();
              },
              child: const Text('Сохранить'),
            ),
          ],
        );
      },
    );
  }
}

class _ScheduleTile extends StatelessWidget {
  final SleepSchedule day;
  final ValueChanged<bool> onToggle;
  final VoidCallback onPickBedtime;
  final VoidCallback onPickWake;
  final VoidCallback onEditWindDown;

  const _ScheduleTile({
    required this.day,
    required this.onToggle,
    required this.onPickBedtime,
    required this.onPickWake,
    required this.onEditWindDown,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          SwitchListTile(
            value: day.enabled,
            onChanged: onToggle,
            title: Text(weekdayName(day.weekday)),
            subtitle: Text('${fmtTimeOfDay(day.bedtime)} — ${fmtTimeOfDay(day.wakeup)}'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onPickBedtime,
                    icon: const Icon(Icons.nights_stay),
                    label: Text('Отбой: ${fmtTimeOfDay(day.bedtime)}'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onPickWake,
                    icon: const Icon(Icons.sunny),
                    label: Text('Подъем: ${fmtTimeOfDay(day.wakeup)}'),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text('Ритуал перед сном'),
            subtitle: Text(day.windDown?.isNotEmpty == true ? day.windDown! : 'Добавьте напоминание'),
            trailing: IconButton(onPressed: onEditWindDown, icon: const Icon(Icons.edit)),
          ),
        ],
      ),
    );
  }
}

String weekdayName(int weekday) {
  const names = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];
  if (weekday < 1 || weekday > 7) return 'День';
  return names[weekday - 1];
}
