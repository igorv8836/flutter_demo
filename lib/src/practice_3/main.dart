import 'package:flutter/material.dart';
import 'state/app_model.dart';
import 'presentation/root_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final model = AppModel();
  @override
  Widget build(BuildContext context) {
    return AppState(
      notifier: model,
      child: AnimatedBuilder(
        animation: model,
        builder: (_, __) => MaterialApp(
          themeMode: model.dark ? ThemeMode.dark : ThemeMode.light,
          theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo), useMaterial3: true),
          darkTheme: ThemeData.dark(useMaterial3: true),
          home: const RootScreen(),
        ),
      ),
    );
  }
}
