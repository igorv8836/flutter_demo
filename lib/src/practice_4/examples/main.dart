import 'package:flutter/material.dart';
import 'package:practice_2/src/practice_4/examples/simple_column_screen.dart';
import 'builder_list_screen.dart';
import 'column_list_screen.dart';
import 'separated_list_screen.dart';
import 'gesture_column_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Васильев Игорь ИКБО-06-22',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Васильев Игорь ИКБО-06-22'),
        ),
        body: Column(
            children: [
              Expanded(
                child: IndexedStack(
                  index: _index,
                  children: [
                    SimpleColumnScreen(),
                    ColumnListScreen(),
                    BuilderListScreen(),
                    SeparatedListScreen(),
                    GestureColumnScreen(),
                  ],
                ),
              ),
            ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _index,
          onTap: (i) => setState(() => _index = i),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.view_column_outlined), label: 'Column'),
            BottomNavigationBarItem(icon: Icon(Icons.view_column), label: 'Scroll Column'),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'ListView'),
            BottomNavigationBarItem(icon: Icon(Icons.view_stream), label: 'Separated'),
            BottomNavigationBarItem(icon: Icon(Icons.gesture), label: 'Gesture'),
          ],
        ),
      ),
    );
  }
}