import 'package:flutter/material.dart';
import '../model/meeting.dart';

class BuilderMeetingsScreen extends StatefulWidget {
  final List<Meeting> meetings;
  final void Function(String title, String time) onAdd;
  final void Function(String id) onDelete;

  const BuilderMeetingsScreen({
    super.key,
    required this.meetings,
    required this.onAdd,
    required this.onDelete,
  });

  @override
  State<BuilderMeetingsScreen> createState() => _BuilderMeetingsScreenState();
}

class _BuilderMeetingsScreenState extends State<BuilderMeetingsScreen> {
  final titleController = TextEditingController();
  final timeController = TextEditingController();

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
                  controller: titleController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Название встречи',
                  ),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 100,
                child: TextField(
                  controller: timeController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Время',
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  widget.onAdd(titleController.text, timeController.text);
                  titleController.clear();
                  timeController.clear();
                },
                child: const Text('Добавить'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: widget.meetings.length,
              itemBuilder: (_, i) {
                final m = widget.meetings[i];
                return ListTile(
                  key: ValueKey(m.id),
                  leading: const Icon(Icons.event),
                  title: Text(m.title),
                  subtitle: Text('Время: ${m.time}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => widget.onDelete(m.id),
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
