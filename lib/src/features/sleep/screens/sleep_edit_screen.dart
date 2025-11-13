import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/di/locator.dart';
import '../../../shared/utils/format.dart';
import '../domain/sleep_repository.dart';
import '../model/sleep_session.dart';

class SleepEditScreen extends StatefulWidget {
  final String sessionId;
  const SleepEditScreen({super.key, required this.sessionId});
  @override
  State<SleepEditScreen> createState() => _SleepEditScreenState();
}

class _SleepEditScreenState extends State<SleepEditScreen> {
  late final TextEditingController _note;
  DateTime? _start;
  DateTime? _end;
  SleepQuality? _quality;
  SleepSession? _session;
  bool _initialized = false;

  _SleepEditScreenState() : _note = TextEditingController();

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  void _ensureSession(SleepRepository repo) {
    if (_initialized) return;
    _session = repo.getById(widget.sessionId);
    if (_session != null) {
      _start = _session!.start;
      _end = _session!.end;
      _quality = _session!.quality;
      _note.text = _session!.note ?? '';
    }
    _initialized = true;
  }

  Future<void> _pickDateTime(bool isStart) async {
    if (_start == null) return;
    final base = isStart ? _start! : (_end ?? DateTime.now());
    final d = await showDatePicker(context: context, firstDate: DateTime(2022), lastDate: DateTime(2100), initialDate: base);
    if (!mounted || d == null) return;
    final t = await showTimePicker(context: context, initialTime: TimeOfDay.fromDateTime(base));
    if (!mounted || t == null) return;
    final dt = DateTime(d.year, d.month, d.day, t.hour, t.minute);
    setState(() {
      if (isStart) {
        _start = dt;
      } else {
        _end = dt;
      }
    });
  }

  void _save() {
    final repo = getIt<SleepRepository>();
    final session = _session;
    final start = _start;
    if (session == null || start == null) return;
    if (_end != null && _end!.isBefore(start)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Окончание раньше начала')));
      return;
    }
    repo.saveSession(session.copyWith(start: start, end: _end, quality: _quality, note: _note.text));
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
    final repo = getIt<SleepRepository>();
    _ensureSession(repo);
    if (_session == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Редактирование')),
        body: const Center(child: Text('Сессия не найдена')),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Редактирование'),
        elevation: 0,
        actions: [IconButton(onPressed: _save, icon: const Icon(Icons.check))],
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
                ListTile(title: const Text('Начало'), subtitle: Text('${fmtDate(_start!)} • ${fmtTime(_start!)}'), onTap: () => _pickDateTime(true)),
                ListTile(title: const Text('Окончание'), subtitle: Text(_end == null ? '—' : '${fmtDate(_end!)} • ${fmtTime(_end!)}'), onTap: () => _pickDateTime(false)),
                InputDecorator(
                  decoration: const InputDecoration(labelText: 'Качество'),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<SleepQuality>(
                      value: _quality,
                      isExpanded: true,
                      items: SleepQuality.values.map((q) => DropdownMenuItem(value: q, child: Text(q.name))).toList(),
                      onChanged: (v) => setState(() => _quality = v),
                      hint: const Text('Не выбрано'),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(controller: _note, decoration: const InputDecoration(labelText: 'Заметка')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
