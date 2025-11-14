import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/utils/format.dart';
import '../application/sleep_edit_form.dart';
import '../model/sleep_session.dart';

class SleepEditScreen extends ConsumerWidget {
  final String sessionId;
  const SleepEditScreen({super.key, required this.sessionId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(sleepEditFormProvider(sessionId));
    final form = ref.read(sleepEditFormProvider(sessionId).notifier);
    final noteController = form.noteController;

    if (noteController.text != state.note) {
      noteController.value = TextEditingValue(
        text: state.note,
        selection: TextSelection.collapsed(offset: state.note.length),
      );
    }

    if (!state.hasSession) {
      return Scaffold(
        appBar: AppBar(title: const Text('Редактирование')),
        body: const Center(child: Text('Сессия не найдена')),
      );
    }

    Future<void> pickDateTime(bool isStart) async {
      final base = isStart
          ? (state.start ?? DateTime.now())
          : (state.end ?? state.start ?? DateTime.now());
      final pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime(2022),
        lastDate: DateTime(2100),
        initialDate: base,
      );
      if (pickedDate == null) return;
      if (!context.mounted) return;
      final pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(base),
      );
      if (pickedTime == null) return;
      if (!context.mounted) return;
      final dt = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );
      if (isStart) {
        form.updateStart(dt);
      } else {
        form.updateEnd(dt);
      }
    }

    void save() {
      final error = form.save();
      if (error != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
        return;
      }
      context.pop();
    }

    final start = state.start;
    final end = state.end;
    final quality = state.quality;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Редактирование'),
        elevation: 0,
        actions: [IconButton(onPressed: save, icon: const Icon(Icons.check))],
      ),
      body: ListView(
        children: [
          CachedNetworkImage(
            imageUrl: _qualityUrl(quality),
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
                ListTile(
                  title: const Text('Начало'),
                  subtitle: Text(start == null ? '—' : '${fmtDate(start)} • ${fmtTime(start)}'),
                  onTap: () => pickDateTime(true),
                ),
                ListTile(
                  title: const Text('Окончание'),
                  subtitle: Text(end == null ? '—' : '${fmtDate(end)} • ${fmtTime(end)}'),
                  onTap: () => pickDateTime(false),
                ),
                InputDecorator(
                  decoration: const InputDecoration(labelText: 'Качество'),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<SleepQuality>(
                      value: quality,
                      isExpanded: true,
                      items: SleepQuality.values
                          .map((q) => DropdownMenuItem(value: q, child: Text(q.name)))
                          .toList(),
                      onChanged: form.updateQuality,
                      hint: const Text('Не выбрано'),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: noteController,
                  onChanged: form.updateNote,
                  decoration: const InputDecoration(labelText: 'Заметка'),
                ),
                if (state.endBeforeStart)
                  const Padding(
                    padding: EdgeInsets.only(top: 8),
                    child: Text(
                      'Окончание раньше начала',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
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
}
