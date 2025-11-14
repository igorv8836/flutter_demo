import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/ui/widgets/timer_panel.dart';
import '../application/sleep_providers.dart';
import '../domain/sleep_controller.dart';

class SleepActiveScreen extends ConsumerWidget {
  final String sessionId;
  const SleepActiveScreen({super.key, required this.sessionId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(sleepControllerProvider.notifier);
    final session = ref.watch(sleepSessionProvider(sessionId));
    final elapsedValue = ref.watch(sleepElapsedProvider(sessionId));
    final elapsed = elapsedValue.maybeWhen(data: (v) => v, orElse: () => Duration.zero);

    if (session == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Активная сессия')),
        body: const Center(child: Text('Сессия не найдена')),
      );
    }

    final isAwake = session.awakenings.isNotEmpty && session.awakenings.last.end == null;
    final url = isAwake
        ? 'https://i.postimg.cc/280yXXsL/free-icon-light-bulb-7446116.png'
        : 'https://i.postimg.cc/44LTCk3Z/free-icon-light-bulb-7446087.png';

    return Scaffold(
      appBar: AppBar(title: const Text('Активная сессия')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: url,
              height: 120,
              width: 40,
              fit: BoxFit.fitHeight,
              placeholder: (c, _) => const SizedBox(height: 180, child: Center(child: CircularProgressIndicator())),
              errorWidget: (c, _, __) => const SizedBox(height: 180, child: Center(child: Icon(Icons.broken_image))),
            ),
          ),
          const SizedBox(height: 16),
          TimerPanel(
            elapsed: elapsed,
            isAwake: isAwake,
            onAwake: controller.toggleAwakening,
            onFinish: () {
              controller.finishActive();
              context.pop();
            },
          ),
        ],
      ),
    );
  }
}
