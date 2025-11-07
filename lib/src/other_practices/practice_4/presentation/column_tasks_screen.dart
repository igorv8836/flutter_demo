import 'package:flutter/material.dart';
import '../model/task.dart';

class ColumnTasksScreen extends StatefulWidget {
  final List<Task> tasks;
  final void Function(String title) onAdd;
  final void Function(String id) onDelete;
  const ColumnTasksScreen({super.key, required this.tasks, required this.onAdd, required this.onDelete});

  @override
  State<ColumnTasksScreen> createState() => _ColumnTasksScreenState();
}

class _ColumnTasksScreenState extends State<ColumnTasksScreen> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Введите задачу',
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
            ...widget.tasks.map((t) => Container(
              key: ValueKey(t.id),
              margin: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                title: Text(t.title),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => widget.onDelete(t.id),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
