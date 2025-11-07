import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../shared/ui/widgets/timer_panel.dart';
import '../model/awakening.dart';

class SleepActiveScreen extends StatefulWidget {
  final DateTime startedAt;
  final List<Awakening> awakenings;
  final VoidCallback onAwakening;
  final VoidCallback onFinish;
  const SleepActiveScreen({super.key, required this.startedAt, required this.awakenings, required this.onAwakening, required this.onFinish});
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
    final url = _isAwake
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
          TimerPanel(elapsed: _elapsed, isAwake: _isAwake, onAwake: widget.onAwakening, onFinish: widget.onFinish),
        ],
      ),
    );
  }
}
