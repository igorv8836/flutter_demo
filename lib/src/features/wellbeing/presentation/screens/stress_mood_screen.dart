import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../wellbeing_controller.dart';
import '../../domain/wellbeing_state.dart';
import '../../../weather/presentation/weather_controller.dart';

class StressMoodScreen extends ConsumerStatefulWidget {
  const StressMoodScreen({super.key});

  @override
  ConsumerState<StressMoodScreen> createState() => _StressMoodScreenState();
}

class _StressMoodScreenState extends ConsumerState<StressMoodScreen> {
  Timer? _timer;
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _timer?.cancel();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(wellbeingControllerProvider);
    final controller = ref.read(wellbeingControllerProvider.notifier);
    final weather = ref.watch(weatherControllerProvider);
    final remaining = _remainingFor(state);
    _ensureTickTimer(state, remaining);

    final stressLabel = state.stress < 0.33
        ? 'Низкий'
        : state.stress < 0.66
            ? 'Средний'
            : 'Высокий';
    final moodLabel = state.mood < 0.33
        ? 'Усталость'
        : state.mood < 0.66
            ? 'Нормально'
            : 'Энергия';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Стресс и настроение'),
        leading: IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Чек-ин за сегодня', style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  Text('Уровень стресса — $stressLabel'),
                  Slider(
                    value: state.stress,
                    onChanged: controller.updateStress,
                    min: 0,
                    max: 1,
                    divisions: 10,
                    label: stressLabel,
                  ),
                  const SizedBox(height: 12),
                  Text('Настроение — $moodLabel'),
                  Slider(
                    value: state.mood,
                    onChanged: controller.updateMood,
                    min: 0,
                    max: 1,
                    divisions: 10,
                    label: moodLabel,
                  ),
                  const SizedBox(height: 8),
                  Wrap(spacing: 8, runSpacing: 8, children: _quickActions()),
                ],
              ),
            ),
          ),
          if (weather.airQuality != null)
            Card(
              child: ListTile(
                leading: const Icon(Icons.air),
                title: Text(
                  'Качество воздуха: ${weather.airQuality!.usAqi?.toString() ?? 'нет данных'}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  'PM2.5: ${weather.airQuality!.pm25.toStringAsFixed(1)}, PM10: ${weather.airQuality!.pm10.toStringAsFixed(1)} • ${weather.airQuality!.advice}',
                ),
              ),
            ),
          if (state.activeAction != null && remaining != null)
            Card(
              child: ListTile(
                leading: const Icon(Icons.timer),
                title: Text(state.activeAction!),
                subtitle: Text(_formatDuration(remaining)),
                trailing: IconButton(
                  tooltip: 'Отмена',
                  onPressed: () {
                    controller.cancelAction();
                    _cancelTimer();
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
            ),
          if (state.waterMl > 0)
            Card(
              child: ListTile(
                leading: const Icon(Icons.water_drop),
                title: const Text('Учтено воды'),
                subtitle: Text('${state.waterMl} мл за сегодня'),
              ),
            ),
          const SizedBox(height: 12),
          const Text('Рекомендации на сегодня', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ..._tips(state).map(
            (tip) => Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  child: Icon(tip.icon, color: Theme.of(context).colorScheme.primary),
                ),
                title: Text(tip.title),
                subtitle: Text(tip.description),
              ),
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.tonalIcon(
            onPressed: controller.reset,
            icon: const Icon(Icons.refresh),
            label: const Text('Сбросить значения'),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  List<Widget> _quickActions() {
    return [
      ActionChip(
        label: const Text('2 мин дыхания'),
        avatar: const Icon(Icons.air, size: 18),
        onPressed: () => _startTimedAction(const Duration(minutes: 2), 'Дыхание'),
      ),
      ActionChip(
        label: const Text('Прогулка 10 мин'),
        avatar: const Icon(Icons.directions_walk, size: 18),
        onPressed: () => _startTimedAction(const Duration(minutes: 10), 'Прогулка'),
      ),
      ActionChip(
        label: const Text('Вода'),
        avatar: const Icon(Icons.water_drop, size: 18),
        onPressed: () => _logWater(),
      ),
      ActionChip(
        label: const Text('Записать мысли'),
        avatar: const Icon(Icons.edit_note, size: 18),
        onPressed: () => _addNote(),
      ),
    ];
  }

  List<_Tip> _tips(WellbeingState state) {
    final tips = <_Tip>[
      const _Tip(
        title: 'Короткая пауза',
        description: 'Сделайте 5 глубоких вдохов и выдохов. Поможет снизить уровень кортизола и сбросить напряжение.',
        icon: Icons.self_improvement,
      ),
      const _Tip(
        title: 'Двигайтесь',
        description: 'Разомнитесь или пройдитесь по комнате — движение помогает стабилизировать настроение.',
        icon: Icons.directions_run,
      ),
      const _Tip(
        title: 'Проверьте питание',
        description: 'Лёгкий перекус с белком и клетчаткой предотвратит резкие скачки энергии.',
        icon: Icons.restaurant,
      ),
      const _Tip(
        title: 'Эко-цифровой детокс',
        description: '15 минут без экрана снизят сенсорную нагрузку и улучшат концентрацию.',
        icon: Icons.do_not_disturb_on,
      ),
    ];

    if (state.stress > 0.66) {
      tips.insert(
        0,
        const _Tip(
          title: 'Выделите ресурсное время',
          description: 'Запланируйте одно простое действие, которое точно успеете сегодня: звонок другу, тёплый чай или прогулка.',
          icon: Icons.timer,
        ),
      );
    }

    if (state.mood < 0.33) {
      tips.add(
        const _Tip(
          title: 'Мягкая поддержка',
          description: 'Напишите другу или коллеге: короткий контакт повышает базовый уровень настроения.',
          icon: Icons.forum,
        ),
      );
    }

    return tips;
  }

  void _startTimedAction(Duration duration, String label) {
    ref.read(wellbeingControllerProvider.notifier).startAction(duration, label);
    _ensureTickTimer(ref.read(wellbeingControllerProvider), duration);
  }

  void _cancelTimer() {
    _timer?.cancel();
    setState(() {
    });
  }

  void _logWater() {
    ref.read(wellbeingControllerProvider.notifier).addWater(200);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('+200 мл учтено')));
  }

  Future<void> _addNote() async {
    _notesController.clear();
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Запишите мысль или эмоцию'),
            const SizedBox(height: 8),
            TextField(
              controller: _notesController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Например: тревожность снизилась после дыхания',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                final text = _notesController.text.trim();
                if (text.isNotEmpty) {
                  ref.read(wellbeingControllerProvider.notifier).saveNote(text);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Запись сохранена: $text')),
                  );
                }
              },
              child: const Text('Сохранить'),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    final hours = d.inHours;
    if (hours > 0) {
      return '$hours:$minutes:$seconds';
    }
    return '$minutes:$seconds';
  }

  Duration? _remainingFor(WellbeingState state) {
    final endsAt = state.actionEndsAt;
    if (state.activeAction == null || endsAt == null) return null;
    final diff = endsAt.difference(DateTime.now());
    if (diff.isNegative) return Duration.zero;
    return diff;
  }

  void _ensureTickTimer(WellbeingState state, Duration? remaining) {
    final shouldRun = state.activeAction != null && remaining != null && remaining > Duration.zero;
    if (shouldRun) {
      _timer ??= Timer.periodic(const Duration(seconds: 1), (_) {
        if (mounted) setState(() {});
      });
    } else {
      _timer?.cancel();
      _timer = null;
      if (state.activeAction != null) {
        ref.read(wellbeingControllerProvider.notifier).cancelAction();
      }
    }
  }
}

class _Tip {
  final String title;
  final String description;
  final IconData icon;

  const _Tip({required this.title, required this.description, required this.icon});
}
