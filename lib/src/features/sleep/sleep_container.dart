import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'application/sleep_providers.dart';
import 'domain/sleep_controller.dart';
import 'model/sleep_session.dart';
import 'screens/sleep_list_screen.dart';

class SleepContainer extends ConsumerWidget {
  const SleepContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(sleepSelectedDateProvider);
    final sessions = ref.watch(sleepSessionsProvider);
    final controller = ref.read(sleepControllerProvider.notifier);

    void startSleep() {
      ref.read(sleepSelectedDateProvider.notifier).set(DateTime.now());
      final router = GoRouter.of(context);
      final activeId = controller.activeSessionId;
      if (activeId != null) controller.finishActive();
      final session = controller.startSession();
      router.push('/sleep/active', extra: session.id);
    }

    void openEdit(SleepSession session) {
      context.push('/sleep/edit', extra: session.id);
    }

    void deleteSession(SleepSession session) {
      final state = ref.read(sleepControllerProvider);
      final index = state.sessions.indexWhere((s) => s.id == session.id);
      if (index == -1) return;
      final removed = controller.deleteSession(session.id);
      if (removed == null) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Удалено'),
          action: SnackBarAction(
            label: 'Отменить',
            onPressed: () => controller.insertSession(removed, index: index),
          ),
        ),
      );
    }

    return SleepListScreen(
      sessions: sessions,
      onStart: startSleep,
      onOpen: openEdit,
      onLock: () => context.pushReplacement("/"),
      onDelete: deleteSession,
      onOpenStats: () => context.push('/stats'),
      onOpenSettings: () => context.push('/settings'),
      date: date,
    );
  }
}
