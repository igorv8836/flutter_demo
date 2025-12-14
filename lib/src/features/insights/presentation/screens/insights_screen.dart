import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../insights_provider.dart';
import '../../core/model/insight.dart';

class InsightsScreen extends ConsumerWidget {
  const InsightsScreen({super.key});

  Color _colorFor(InsightSeverity severity, BuildContext context) {
    switch (severity) {
      case InsightSeverity.positive:
        return Colors.green.shade600;
      case InsightSeverity.warning:
        return Colors.orange.shade700;
      case InsightSeverity.info:
        return Theme.of(context).colorScheme.primary;
    }
  }

  IconData _iconFor(InsightSeverity severity) {
    switch (severity) {
      case InsightSeverity.positive:
        return Icons.check_circle;
      case InsightSeverity.warning:
        return Icons.warning_amber;
      case InsightSeverity.info:
        return Icons.lightbulb;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final insights = ref.watch(insightsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Инсайты и рекомендации'),
        leading: IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ...insights.map(
            (i) => Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(_iconFor(i.severity), color: _colorFor(i.severity, context)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            i.title,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: _colorFor(i.severity, context),
                            ),
                          ),
                        ),
                        Builder(builder: (context) {
                          final color = _colorFor(i.severity, context);
                          return Chip(
                            label: Text(_label(i.severity)),
                            backgroundColor: color.withValues(alpha: 0.1),
                            labelStyle: TextStyle(color: color),
                          );
                        }),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(i.description),
                    const SizedBox(height: 12),
                    Text(
                      i.action,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (insights.isEmpty)
            const Padding(
              padding: EdgeInsets.all(24),
              child: Text('Инсайтов пока нет — продолжайте вести дневник сна.'),
            ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  String _label(InsightSeverity severity) {
    switch (severity) {
      case InsightSeverity.positive:
        return 'Прогресс';
      case InsightSeverity.warning:
        return 'Внимание';
      case InsightSeverity.info:
        return 'Совет';
    }
  }
}
