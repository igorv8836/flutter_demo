import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/di/locator.dart';
import '../../../shared/ui/widgets/timer_panel.dart';
import '../domain/sleep_repository.dart';

class SleepActiveScreen extends StatefulWidget {
  final String sessionId;
  const SleepActiveScreen({super.key, required this.sessionId});

  @override
  State<SleepActiveScreen> createState() => _SleepActiveScreenState();
}

class _SleepActiveScreenState extends State<SleepActiveScreen> {
  Timer? _timer;
  Duration _elapsed = Duration.zero;

  SleepRepository get _repo => getIt<SleepRepository>();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _updateElapsed());
    _updateElapsed();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _updateElapsed() {
    if (!mounted) return;
    final session = _repo.getById(widget.sessionId);
    if (session == null) return;
    setState(() => _elapsed = DateTime.now().difference(session.start));
  }

  @override
  Widget build(BuildContext context) {
    SleepRepository? repo;

    if (getIt.isRegistered<SleepRepository>()) {
      repo = getIt.get<SleepRepository>();
    } else {
      print('Error: SleepRepository not found');
    }

    final session = repo!.getById(widget.sessionId);
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
            elapsed: _elapsed,
            isAwake: isAwake,
            onAwake: () {
              repo!.toggleAwakening();
              setState(() {});
            },
            onFinish: () {
              repo!.finishActive();
              if (mounted) context.pop();
            },
          ),
        ],
      ),
    );
  }
}
