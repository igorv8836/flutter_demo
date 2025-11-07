import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../shared/utils/format.dart';
import '../../../shared/ui/widgets/metric_card.dart';
import '../../sleep/model/sleep_session.dart';
import '../../settings/model/settings.dart';
import '../stats_service.dart';

class StatsScreen extends StatelessWidget {
  final List<SleepSession> sessions;
  final Settings settings;
  final VoidCallback? onClose;

  const StatsScreen({
    super.key,
    required this.sessions,
    required this.settings,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final s7 = StatsService().compute(sessions, settings, days: 7);
    final s30 = StatsService().compute(sessions, settings, days: 30);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Статистика'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('7 дней', style: TextStyle(fontWeight: FontWeight.bold)),
          MetricCard(
            title: 'Средняя длительность',
            value: fmtHm(s7.avgDuration),
            imageUrl: "https://i.postimg.cc/3rvJZxBb/free-icon-timer-45443.png",
          ),
          MetricCard(
            title: 'Эффективность',
            value: '${(s7.efficiency * 100).round()}%',
            imageUrl:
                "https://i.postimg.cc/gjQZQS5G/free-icon-lighting-7016896.png",
          ),
          MetricCard(
            title: 'Регулярность',
            value: '${s7.regularity.inMinutes} мин',
            imageUrl:
                "https://i.postimg.cc/GpX96g8T/free-icon-calendar-7691413.png",
          ),
          MetricCard(
            title: 'Sleep Score',
            value: s7.sleepScore.toString(),
            trailing: LinearProgressIndicator(
              value: s7.sleepScore / 100,
              minHeight: 8,
            ),
            imageUrl:
                "https://i.postimg.cc/7PGN4d1n/free-icon-three-star-17933526.png",
          ),
          const SizedBox(height: 12),
          const Text('30 дней', style: TextStyle(fontWeight: FontWeight.bold)),
          MetricCard(
            title: 'Средняя длительность',
            value: fmtHm(s30.avgDuration),
            imageUrl: "https://i.postimg.cc/3rvJZxBb/free-icon-timer-45443.png",
          ),
          MetricCard(
            title: 'Эффективность',
            value: '${(s30.efficiency * 100).round()}%',
            imageUrl:
            "https://i.postimg.cc/gjQZQS5G/free-icon-lighting-7016896.png",
          ),
          MetricCard(
            title: 'Регулярность',
            value: '${s30.regularity.inMinutes} мин',
            imageUrl:
            "https://i.postimg.cc/GpX96g8T/free-icon-calendar-7691413.png",
          ),
          MetricCard(
            title: 'Sleep Score',
            value: s30.sleepScore.toString(),
            trailing: LinearProgressIndicator(
              value: s30.sleepScore / 100,
              minHeight: 8,
            ),
            imageUrl:
            "https://i.postimg.cc/7PGN4d1n/free-icon-three-star-17933526.png",
          ),
        ],
      ),
    );
  }
}
