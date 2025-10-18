import 'package:flutter/material.dart';
import '../../../shared/utils/format.dart';
import '../model/sleep_session.dart';

class SleepEditScreen extends StatefulWidget {
  final SleepSession session;
  final void Function(SleepSession) onSave;
  const SleepEditScreen({super.key, required this.session, required this.onSave});
  @override
  State<SleepEditScreen> createState() => _SleepEditScreenState();
}

class _SleepEditScreenState extends State<SleepEditScreen> {
  late DateTime _start;
  DateTime? _end;
  SleepQuality? _quality;
  final _note = TextEditingController();
  @override
  void initState() {
    super.initState();
    _start = widget.session.start;
    _end = widget.session.end;
    _quality = widget.session.quality;
    _note.text = widget.session.note ?? '';
  }
  Future<void> _pickDateTime(bool isStart) async {
    final d = await showDatePicker(context: context, firstDate: DateTime(2022), lastDate: DateTime(2100), initialDate: isStart ? _start : (_end ?? DateTime.now()));
    if (d == null) return;
    final t = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(isStart ? _start : (_end ?? DateTime.now())));
    if (t == null) return;
    final dt = DateTime(d.year, d.month, d.day, t.hour, t.minute);
    setState(() {
      if (isStart) _start = dt; else _end = dt;
    });
  }
  void _save() {
    if (_end != null && _end!.isBefore(_start)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Окончание раньше начала')));
      return;
    }
    widget.onSave(widget.session.copyWith(start: _start, end: _end, quality: _quality, note: _note.text));
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Редактирование'), actions: [IconButton(onPressed: _save, icon: const Icon(Icons.check))]),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(title: const Text('Начало'), subtitle: Text('${fmtDate(_start)} • ${fmtTime(_start)}'), onTap: () => _pickDateTime(true)),
          ListTile(title: const Text('Окончание'), subtitle: Text(_end == null ? '—' : '${fmtDate(_end!)} • ${fmtTime(_end!)}'), onTap: () => _pickDateTime(false)),
          DropdownButtonFormField<SleepQuality>(
            value: _quality,
            items: SleepQuality.values.map((q) => DropdownMenuItem(value: q, child: Text(q.name))).toList(),
            onChanged: (v) => setState(() => _quality = v),
            decoration: const InputDecoration(labelText: 'Качество'),
          ),
          const SizedBox(height: 12),
          TextFormField(controller: _note, decoration: const InputDecoration(labelText: 'Заметка')),
        ],
      ),
    );
  }
}
