import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/di/app_scope.dart';
import '../domain/settings_repository.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Duration? _target;
  TimeOfDay? _bedtime;
  SettingsRepository? _repository;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final repo = AppScope.of(context).settingsRepository;
    if (_repository != repo) {
      _repository = repo;
      _initialized = false;
    }
    if (!_initialized) {
      final settings = repo.settings;
      _target ??= settings.targetDuration;
      _bedtime ??= settings.targetBedtime;
      _initialized = true;
    }
  }

  Future<void> _pickTarget() async {
    if (_target == null) return;
    final h = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: _target!.inHours, minute: _target!.inMinutes.remainder(60)),
    );
    if (h != null) setState(() => _target = Duration(hours: h.hour, minutes: h.minute));
  }

  Future<void> _pickBedtime() async {
    final bedtime = _bedtime;
    if (bedtime == null) return;
    final t = await showTimePicker(context: context, initialTime: bedtime);
    if (t != null) setState(() => _bedtime = t);
  }

  void _save() {
    final repo = _repository;
    if (repo == null || _target == null || _bedtime == null) return;
    repo.update(repo.settings.copyWith(targetDuration: _target, targetBedtime: _bedtime));
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    if (_target == null || _bedtime == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Настройки'), actions: [IconButton(onPressed: _save, icon: const Icon(Icons.check))]),
      body: ListView(
        children: [
          CachedNetworkImage(
            imageUrl: 'https://mir-s3-cdn-cf.behance.net/e4f6c8c8468adcb8a48dbf6954bf107f/e8abd2ef-973f-407a-a0d7-11e1f228035a_rwc_0x681x1920x268x1920.jpg?h=341110f16f7600679ef49cb7b2cf7856',
            height: 180,
            fit: BoxFit.cover,
            placeholder: (c, _) => const SizedBox(height: 180, child: Center(child: CircularProgressIndicator())),
            errorWidget: (c, _, __) => const SizedBox(height: 180, child: Center(child: Icon(Icons.broken_image))),
          ),
          ListTile(title: const Text('Целевая длительность'), subtitle: Text('${_target!.inHours} ч ${_target!.inMinutes.remainder(60)} мин'), onTap: _pickTarget),
          ListTile(title: const Text('Желаемое время отбоя'), subtitle: Text('${_bedtime!.hour.toString().padLeft(2, '0')}:${_bedtime!.minute.toString().padLeft(2, '0')}'), onTap: _pickBedtime),
        ],
      ),
    );
  }
}
