import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../model/settings.dart';

class SettingsScreen extends StatefulWidget {
  final Settings initial;
  final void Function(Settings) onSave;
  const SettingsScreen({super.key, required this.initial, required this.onSave});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late Duration _target;
  late TimeOfDay _bedtime;
  @override
  void initState() {
    super.initState();
    _target = widget.initial.targetDuration;
    _bedtime = widget.initial.targetBedtime;
  }
  Future<void> _pickTarget() async {
    final h = await showTimePicker(context: context, initialTime: TimeOfDay(hour: _target.inHours, minute: _target.inMinutes.remainder(60)));
    if (h != null) setState(() => _target = Duration(hours: h.hour, minutes: h.minute));
  }
  Future<void> _pickBedtime() async {
    final t = await showTimePicker(context: context, initialTime: _bedtime);
    if (t != null) setState(() => _bedtime = t);
  }
  void _save() {
    widget.onSave(widget.initial.copyWith(targetDuration: _target, targetBedtime: _bedtime));
    context.pop();
  }
  @override
  Widget build(BuildContext context) {
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
          ListTile(title: const Text('Целевая длительность'), subtitle: Text('${_target.inHours} ч ${_target.inMinutes.remainder(60)} мин'), onTap: _pickTarget),
          ListTile(title: const Text('Желаемое время отбоя'), subtitle: Text('${_bedtime.hour.toString().padLeft(2, '0')}:${_bedtime.minute.toString().padLeft(2, '0')}'), onTap: _pickBedtime),
        ],
      ),
    );
  }
}
