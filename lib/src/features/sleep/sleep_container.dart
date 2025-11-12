import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../shared/di/app_scope.dart';
import 'domain/sleep_repository.dart';
import 'model/sleep_session.dart';
import 'screens/sleep_list_screen.dart';

class SleepContainer extends StatefulWidget {
  const SleepContainer({super.key});
  @override
  State<SleepContainer> createState() => _SleepContainerState();
}

class _SleepContainerState extends State<SleepContainer> {
  final DateTime _currentDate = DateTime.now();

  SleepRepository get _repo => AppScope.of(context).sleepRepository;

  void _startSleep() {
    final repo = _repo;
    final activeId = repo.activeSessionId;
    final session = activeId != null ? repo.getById(activeId) ?? repo.startSession() : repo.startSession();
    context.push('/sleep/active', extra: session.id);
  }

  void _openEdit(SleepSession session) {
    context.push('/sleep/edit', extra: session.id);
  }

  void _delete(SleepSession session) {
    final repo = _repo;
    final index = repo.sessions.indexWhere((s) => s.id == session.id);
    if (index == -1) return;
    final removed = repo.deleteSession(session.id);
    if (removed == null) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Удалено'),
        action: SnackBarAction(
          label: 'Отменить',
          onPressed: () => repo.insertSession(removed, index: index),
        ),
      ),
    );
  }

  void _openStats() => context.push('/stats');
  void _openSettings() => context.push('/settings');

  @override
  Widget build(BuildContext context) {
    final sleepRepo = AppScope.of(context).sleepRepository;
    final sessions = sleepRepo.sessionsForDate(_currentDate);
    return SleepListScreen(
      sessions: sessions,
      onStart: _startSleep,
      onOpen: _openEdit,
      onLock: () => context.pushReplacement("/"),
      onDelete: _delete,
      onOpenStats: _openStats,
      onOpenSettings: _openSettings,
      date: _currentDate,
    );
  }
}
