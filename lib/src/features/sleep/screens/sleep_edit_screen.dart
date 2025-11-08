import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
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
    context.pop();
  }

  String _qualityUrl(SleepQuality? q) {
    switch (q) {
      case SleepQuality.great:
      case SleepQuality.good:
        return 'https://i.postimg.cc/j2XQD0M8/i.webp';
      case SleepQuality.fair:
        return 'https://i.postimg.cc/K8cprQLK/600011875033b0.jpg';
      case SleepQuality.poor:
        return 'https://i.postimg.cc/Y9zPkVB3/fog-trees-bw-157820-3840x2400.jpg';
      default:
        return 'https://i.postimg.cc/K8cprQLK/600011875033b0.jpg';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Редактирование'),
          elevation: 0,
          actions: [IconButton(onPressed: _save, icon: const Icon(Icons.check))]
      ),
      body: ListView(
        children: [
          CachedNetworkImage(
            imageUrl: _qualityUrl(_quality),
            height: 160,
            fit: BoxFit.cover,
            placeholder: (c, _) => const SizedBox(height: 160, child: Center(child: CircularProgressIndicator())),
            errorWidget: (c, _, __) => const SizedBox(height: 160, child: Center(child: Icon(Icons.broken_image))),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 12),
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
              ]
            ),
          ),
        ],
      ),
    );
  }
}
