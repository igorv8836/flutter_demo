import 'dart:async';
import 'package:flutter/material.dart';
import '../../../shared/ui/widgets/timer_panel.dart';
import '../model/awakening.dart';

class SleepActiveScreen extends StatefulWidget {
  final DateTime startedAt;
  final List<Awakening> awakenings;
  final VoidCallback onAwakening;
  final VoidCallback onFinish;
  const SleepActiveScreen({
    super.key,
    required this.startedAt,
    required this.awakenings,
    required this.onAwakening,
    required this.onFinish,
  });

  @override
  State<SleepActiveScreen> createState() => _SleepActiveScreenState();
}

class _SleepActiveScreenState extends State<SleepActiveScreen> {
  late Timer _t;
  Duration _elapsed = Duration.zero;

  @override
  void initState() {
    super.initState();
    _elapsed = DateTime.now().difference(widget.startedAt);
    _t = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _elapsed = DateTime.now().difference(widget.startedAt));
    });
  }

  @override
  void dispose() {
    _t.cancel();
    super.dispose();
  }

  bool get _isAwake =>
      widget.awakenings.isNotEmpty && widget.awakenings.last.end == null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Активная сессия')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: TimerPanel(
          elapsed: _elapsed,
          isAwake: _isAwake,
          onAwake: widget.onAwakening,
          onFinish: widget.onFinish,
        ),
      ),
    );
  }
}
