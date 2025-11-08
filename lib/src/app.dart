import 'package:flutter/material.dart';
import 'package:practice_2/src/features/password/password_screen.dart';
import 'app_model.dart';
import 'features/sleep/sleep_container.dart';
import 'features/stats/screens/stats_screen.dart';
import 'features/settings/screens/settings_screen.dart';

class SleepApp extends StatefulWidget {
  const SleepApp({super.key});
  @override
  State<SleepApp> createState() => _SleepAppState();
}

class _SleepAppState extends State<SleepApp> {
  late final AppModel model;

  @override
  void initState() {
    super.initState();
    model = AppModel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Трекер сна',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      darkTheme: ThemeData.dark(useMaterial3: true),
      home: PasswordScreen(),
    );
  }
}
