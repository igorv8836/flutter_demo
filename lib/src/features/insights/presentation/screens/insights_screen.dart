import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../insights_provider.dart';
import '../../core/model/insight.dart';
import '../../../weather/presentation/weather_controller.dart';
import '../../../quotes/presentation/quotes_controller.dart';
import '../../../../shared/utils/format.dart';

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
    final weather = ref.watch(weatherControllerProvider);
    final quotes = ref.watch(quotesControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Инсайты и рекомендации'),
        leading: IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _WeatherCard(state: weather, onRefresh: () => ref.read(weatherControllerProvider.notifier).refresh()),
          const SizedBox(height: 12),
          const Text('Цитаты', style: TextStyle(fontWeight: FontWeight.bold)),
          if (quotes.sleepQuotes.isEmpty && quotes.isLoading)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Center(child: CircularProgressIndicator()),
            ),
          ...quotes.sleepQuotes.take(2).map((q) => Card(
                child: ListTile(
                  title: Text(q.content),
                  subtitle: Text(q.author),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text(q.author),
                        content: Text(q.content),
                        actions: [TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Закрыть'))],
                      ),
                    );
                  },
                ),
              )),
          const SizedBox(height: 12),
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

class _WeatherCard extends StatelessWidget {
  final WeatherState state;
  final VoidCallback onRefresh;
  const _WeatherCard({required this.state, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    final points = state.hourly?.points.take(3).toList() ?? const [];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.cloud),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    state.location?.city ?? 'Укажите город в настройках',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                IconButton(onPressed: onRefresh, icon: const Icon(Icons.refresh)),
              ],
            ),
            if (state.isLoading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: LinearProgressIndicator(minHeight: 4),
              ),
            if (state.error != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(state.error!, style: const TextStyle(color: Colors.red)),
              ),
            if (points.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Wrap(
                  spacing: 12,
                  runSpacing: 8,
                  children: points
                      .map(
                        (p) => Chip(
                          label: Text('${fmtTime(p.time)}  ${p.temperature.toStringAsFixed(1)}° • ${p.precipitation.toStringAsFixed(1)} мм'),
                          avatar: Icon(p.cloudCover > 70 ? Icons.cloud : Icons.wb_sunny, size: 18),
                        ),
                      )
                      .toList(),
                ),
              ),
            if (points.isEmpty && !state.isLoading)
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text('Нет прогноза — обновите или задайте город'),
              ),
          ],
        ),
      ),
    );
  }
}
