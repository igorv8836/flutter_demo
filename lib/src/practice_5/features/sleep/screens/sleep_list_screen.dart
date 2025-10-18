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
  final VoidCallback onOpenSettings;
  final DateTime date;
  const SleepListScreen({
    super.key,
    required this.sessions,
    required this.onStart,
    required this.onOpen,
    required this.onDelete,
    required this.onOpenStats,
    required this.onOpenSettings,
    required this.date,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Сон • ${fmtDate(date)}'),
        actions: [
          IconButton(onPressed: onOpenStats, icon: const Icon(Icons.insights)),
          IconButton(onPressed: onOpenSettings, icon: const Icon(Icons.settings)),
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
      floatingActionButton: FloatingActionButton.extended(onPressed: onStart, label: const Text('Начать сон'), icon: const Icon(Icons.nights_stay)),
    );
  }
}
