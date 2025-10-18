import 'package:flutter/material.dart';
import 'features/sleep/sleep_container.dart';

class SleepApp extends StatelessWidget {
  const SleepApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Трекер сна',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: const SleepContainer(),
    );
  }
}
