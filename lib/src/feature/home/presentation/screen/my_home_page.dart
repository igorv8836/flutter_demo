import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  final String fio = 'Васильев Игорь Юрьевич';
  final String group = 'Группа ИКБО-06-22';
  final String studentId = 'Студенческий билет №22И1109';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(fio, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 12),
            Text(group, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            Text(studentId, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}