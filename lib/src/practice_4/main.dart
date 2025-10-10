import 'package:flutter/material.dart';
import 'model/task.dart';
import 'model/meeting.dart';
import 'model/note.dart';
import 'presentation/column_tasks_screen.dart';
import 'presentation/builder_meetings_screen.dart';
import 'presentation/separated_notes_screen.dart';

void main() => runApp(const TaskApp());

class TaskApp extends StatefulWidget {
  const TaskApp({super.key});

  @override
  State<TaskApp> createState() => _TaskAppState();
}

class _TaskAppState extends State<TaskApp> {
  int index = 0;

  final List<Task> tasks = [
    const Task(id: 't1', title: 'Подготовить отчёт'),
    const Task(id: 't2', title: 'Созвон с заказчиком'),
  ];

  final List<Meeting> meetings = [
    const Meeting(id: 'm1', title: 'Встреча с командой', time: '10:00'),
    const Meeting(id: 'm2', title: 'Презентация проекта', time: '15:30'),
  ];

  final List<Note> notes = [
    const Note(id: 'n1', text: 'Проверить дедлайны'),
    const Note(id: 'n2', text: 'Отправить приглашения'),
  ];

  int counter = 3;

  void addTask(String title) {
    final t = title.trim();
    if (t.isEmpty) return;
    setState(() {
      counter++;
      tasks.add(Task(id: 't$counter', title: t));
    });
  }

  void deleteTask(String id) {
    setState(() => tasks.removeWhere((t) => t.id == id));
  }

  void addMeeting(String title, String time) {
    if (title.trim().isEmpty || time.trim().isEmpty) return;
    setState(() {
      counter++;
      meetings.add(Meeting(id: 'm$counter', title: title.trim(), time: time.trim()));
    });
  }

  void deleteMeeting(String id) {
    setState(() => meetings.removeWhere((m) => m.id == id));
  }

  void addNote(String text) {
    final t = text.trim();
    if (t.isEmpty) return;
    setState(() {
      counter++;
      notes.add(Note(id: 'n$counter', text: t));
    });
  }

  void deleteNote(String id) {
    setState(() => notes.removeWhere((n) => n.id == id));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Практическая работа 4',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Васильев Игорь ИКБО-06-22')),
        body: IndexedStack(
          index: index,
          children: [
            ColumnTasksScreen(tasks: tasks, onAdd: addTask, onDelete: deleteTask),
            BuilderMeetingsScreen(meetings: meetings, onAdd: addMeeting, onDelete: deleteMeeting),
            SeparatedNotesScreen(notes: notes, onAdd: addNote, onDelete: deleteNote),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index,
          onTap: (i) => setState(() => index = i),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Задачи'),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Встречи'),
            BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Заметки'),
          ],
        ),
      ),
    );
  }
}
