import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practice_2/src/features/settings/screens/settings_screen.dart';
import 'package:practice_2/src/features/sleep/screens/sleep_active_screen.dart';
import 'package:practice_2/src/features/stats/screens/stats_screen.dart';
import 'package:uuid/uuid.dart';

import '../../app_model.dart';
import '../password/password_screen.dart';
import '../settings/model/settings.dart';
import 'model/awakening.dart';
import 'model/sleep_session.dart';
import 'screens/sleep_edit_screen.dart';
import 'screens/sleep_list_screen.dart';

class SleepContainer extends StatefulWidget {
  final AppModel model;
  const SleepContainer({super.key, required this.model});
  @override
  State<SleepContainer> createState() => _SleepContainerState();
}

class _SleepContainerState extends State<SleepContainer> {
  final _uuid = const Uuid();
  String? _activeId;
  DateTime _currentDate = DateTime.now();

  List<SleepSession> get _sessions => widget.model.sessions;
  Settings get _settings => widget.model.settings;

  List<SleepSession> get _today => _sessions.where((s) =>
  s.start.year == _currentDate.year &&
      s.start.month == _currentDate.month &&
      s.start.day == _currentDate.day).toList().reversed.toList();

  void _startSleep() {
    final id = _uuid.v4();
    final s = SleepSession(id: id, start: DateTime.now());
    setState(() {
      _sessions.add(s);
      _activeId = id;
    });
    context.push('/sleep/active', extra: {
      'session': s,
      'onAwakening': _addAwakening,
      'onFinish': _finishSleep,
    });
  }

  void _finishSleep() {
    final i = _sessions.indexWhere((s) => s.id == _activeId);
    if (i == -1) return;
    final ended = DateTime.now();
    final updated = _sessions[i].copyWith(end: ended);
    setState(() {
      _sessions[i] = updated;
      _activeId = null;
    });

    context.pop();
  }

  void _addAwakening() {
    final i = _sessions.indexWhere((s) => s.id == _activeId);
    if (i == -1) return;
    final cur = _sessions[i];
    final opens = cur.awakenings.where((a) => a.end == null).toList();
    if (opens.isEmpty) {
      final newList = [...cur.awakenings, Awakening(start: DateTime.now())];
      setState(() => _sessions[i] = cur.copyWith(awakenings: newList));
    } else {
      final idx = cur.awakenings.lastIndexOf(opens.last);
      final closed = cur.awakenings[idx].copyWith(end: DateTime.now());
      final list = [...cur.awakenings]..[idx] = closed;
      setState(() => _sessions[i] = cur.copyWith(awakenings: list));
    }
  }

  void _openEdit(SleepSession s) {
    context.push('/sleep/edit', extra: {
      'session': s,
      'onSave': _saveSession,
    });
  }

  void _saveSession(SleepSession s) {
    final idx = _sessions.indexWhere((e) => e.id == s.id);
    if (idx >= 0) {
      _sessions[idx] = s;
      setState(() {});
      context.pop();
    }
  }

  void _delete(SleepSession s) {
    final i = _sessions.indexWhere((x) => x.id == s.id);
    if (i == -1) return;
    final removed = _sessions.removeAt(i);
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Удалено'),
      action: SnackBarAction(label: 'Отменить', onPressed: () {
        setState(() => _sessions.insert(i, removed));
      }),
    ));
  }

  void _openStats() {
    context.push('/stats', extra: {
      'sessions': _sessions,
      'settings': _settings,
      'onClose': () => context.pop(),
    });
  }

  void _openSettings() {
    context.push('/settings', extra: {
      'initial': _settings,
      'onSave': (Settings s) => widget.model.settings = s,
    });
  }

  @override
  Widget build(BuildContext context) {
    return SleepListScreen(
      sessions: _today,
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
