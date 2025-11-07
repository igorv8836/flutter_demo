import 'package:flutter/material.dart';
import '../../utils/format.dart';

class TimerPanel extends StatelessWidget {
  final Duration elapsed;
  final bool isAwake;
  final VoidCallback onAwake;
  final VoidCallback onFinish;
  const TimerPanel({
    super.key,
    required this.elapsed,
    required this.isAwake,
    required this.onAwake,
    required this.onFinish,
  });

  @override
  Widget build(BuildContext context) {
    final label = isAwake ? 'Я снова заснул' : 'Пробуждение';
    final color = isAwake ? Colors.green : Colors.orange;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(fmtHm(elapsed), style: Theme.of(context).textTheme.displaySmall),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    style: FilledButton.styleFrom(backgroundColor: color),
                    onPressed: onAwake,
                    child: Text(label),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.tonal(
                    onPressed: onFinish,
                    child: const Text('Завершить сон'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
