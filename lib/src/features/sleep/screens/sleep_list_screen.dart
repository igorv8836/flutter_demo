import 'package:flutter/material.dart';
import '../../../shared/ui/widgets/sleep_row.dart';
import '../../../shared/utils/format.dart';
import '../model/sleep_session.dart';

class SleepListScreen extends StatelessWidget {
  final List<SleepSession> sessions;
  final VoidCallback onStart;
  final void Function(SleepSession) onOpen;
  final void Function(SleepSession) onDelete;
  final VoidCallback onOpenStats;
  final VoidCallback onOpenGoals;
  final VoidCallback onOpenPlanner;
  final VoidCallback onOpenInsights;
  final VoidCallback onOpenSettings;
  final VoidCallback onOpenWellbeing;
  final VoidCallback onOpenProfile;
  final VoidCallback onLock;
  final DateTime date;
  const SleepListScreen({
    super.key,
    required this.sessions,
    required this.onStart,
    required this.onOpen,
    required this.onDelete,
    required this.onOpenStats,
    required this.onOpenGoals,
    required this.onOpenPlanner,
    required this.onOpenInsights,
    required this.onOpenSettings,
    required this.onOpenWellbeing,
    required this.onOpenProfile,
    required this.onLock,
    required this.date,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Сон • ${fmtDate(date)}'),
        actions: [
          IconButton(onPressed: () => onOpenGoals(), tooltip: 'Цели', icon: const Icon(Icons.flag)),
          IconButton(onPressed: () => onOpenPlanner(), tooltip: 'Режим', icon: const Icon(Icons.schedule)),
          IconButton(onPressed: () => onOpenInsights(), tooltip: 'Инсайты', icon: const Icon(Icons.tips_and_updates)),
          IconButton(onPressed: () => onOpenStats(), tooltip: 'Статистика', icon: const Icon(Icons.insights)),
          IconButton(onPressed: () => onOpenSettings(), tooltip: 'Настройки', icon: const Icon(Icons.settings)),
          IconButton(onPressed: () => onOpenWellbeing(), tooltip: 'Стресс и настроение', icon: const Icon(Icons.self_improvement)),
          IconButton(onPressed: () => onOpenProfile(), tooltip: 'Профиль', icon: const Icon(Icons.person)),
        ],
      ),
      body: ListView.builder(
        itemCount: sessions.length,
        itemBuilder: (c, i) {
          final s = sessions[i];
          return SleepRow(
            session: s,
            onTap: () => onOpen(s),
            onDelete: () => onDelete(s),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: onStart,
            label: const Text('Начать сон'),
            icon: const Icon(Icons.nights_stay),
            heroTag: 'start',
          ),
          const SizedBox(height: 12),
          FloatingActionButton.extended(
            onPressed: onLock,
            label: const Text('Выйти'),
            icon: const Icon(Icons.logout),
            heroTag: 'block',
          ),
        ],
      ),
    );
  }
}
