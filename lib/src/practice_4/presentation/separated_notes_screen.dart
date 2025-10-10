import 'package:flutter/material.dart';
import '../model/note.dart';

class SeparatedNotesScreen extends StatefulWidget {
  final List<Note> notes;
  final void Function(String text) onAdd;
  final void Function(String id) onDelete;
  const SeparatedNotesScreen({super.key, required this.notes, required this.onAdd, required this.onDelete});

  @override
  State<SeparatedNotesScreen> createState() => _SeparatedNotesScreenState();
}

class _SeparatedNotesScreenState extends State<SeparatedNotesScreen> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Введите заметку',
                  ),
                  onSubmitted: (v) {
                    widget.onAdd(v);
                    controller.clear();
                  },
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  widget.onAdd(controller.text);
                  controller.clear();
                },
                child: const Text('Добавить'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.separated(
              itemCount: widget.notes.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (_, i) {
                final n = widget.notes[i];
                return ListTile(
                  key: ValueKey(n.id),
                  leading: const Icon(Icons.note_alt_outlined),
                  title: Text(n.text),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => widget.onDelete(n.id),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
