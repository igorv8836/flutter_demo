import 'package:flutter/material.dart';
import '../../../shared/utils/format.dart';
import '../../../shared/ui/widgets/metric_card.dart';
import '../../sleep/model/sleep_session.dart';
import '../../settings/model/settings.dart';
import '../stats_service.dart';

class StatsScreen extends StatelessWidget {
  final List<SleepSession> sessions;
  final Settings settings;
  final VoidCallback? onClose;
  const StatsScreen({super.key, required this.sessions, required this.settings, this.onClose});

  @override
  Widget build(BuildContext context) {
    final s7 = StatsService().compute(sessions, settings, days: 7);
    final s30 = StatsService().compute(sessions, settings, days: 30);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Статистика'),
        leading: IconButton(onPressed: onClose, icon: const Icon(Icons.arrow_back)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('7 дней', style: TextStyle(fontWeight: FontWeight.bold)),
          MetricCard(title: 'Средняя длительность', value: fmtHm(s7.avgDuration)),
          MetricCard(title: 'Эффективность', value: '${(s7.efficiency * 100).round()}%'),
          MetricCard(title: 'Регулярность', value: '${s7.regularity.inMinutes} мин'),
          MetricCard(title: 'Sleep Score', value: s7.sleepScore.toString(), trailing: LinearProgressIndicator(value: s7.sleepScore / 100, minHeight: 8)),
          const SizedBox(height: 12),
          const Text('30 дней', style: TextStyle(fontWeight: FontWeight.bold)),
          MetricCard(title: 'Средняя длительность', value: fmtHm(s30.avgDuration)),
          MetricCard(title: 'Эффективность', value: '${(s30.efficiency * 100).round()}%'),
          MetricCard(title: 'Регулярность', value: '${s30.regularity.inMinutes} мин'),
          MetricCard(title: 'Sleep Score', value: s30.sleepScore.toString(), trailing: LinearProgressIndicator(value: s30.sleepScore / 100, minHeight: 8)),
        ],
      ),
    );
  }
}
