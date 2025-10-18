import 'package:flutter/material.dart';
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
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Настройки'), actions: [IconButton(onPressed: _save, icon: const Icon(Icons.check))]),
      body: ListView(
        children: [
          ListTile(title: const Text('Целевая длительность'), subtitle: Text('${_target.inHours} ч ${_target.inMinutes.remainder(60)} мин'), onTap: _pickTarget),
          ListTile(title: const Text('Желаемое время отбоя'), subtitle: Text('${_bedtime.hour.toString().padLeft(2, '0')}:${_bedtime.minute.toString().padLeft(2, '0')}'), onTap: _pickBedtime),
        ],
      ),
    );
  }
}
