import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_model.dart';
import 'features/root_tabs/root_tabs.dart';
import 'features/sleep/screens/sleep_active_screen.dart';
import 'features/sleep/screens/sleep_edit_screen.dart';

class SleepApp extends StatefulWidget {
  const SleepApp({super.key});
  @override
  State<SleepApp> createState() => _SleepAppState();
}

class _SleepAppState extends State<SleepApp> {
  late final AppModel model;
  late final GoRouter router;

  @override
  void initState() {
    super.initState();
    model = AppModel();

    router = GoRouter(
      initialLocation: '/sleep',
      routes: [
        GoRoute(
          path: '/sleep',
          builder: (c, s) => RootTabs(model: model),
          routes: [
            GoRoute(
              path: 'active',
              builder: (c, s) => SleepActiveScreen(
                startedAt: DateTime.now(),
                awakenings: const [],
                onAwakening: () {},
                onFinish: () => GoRouter.of(c).pop(),
              ),
            ),
            GoRoute(
              path: 'edit',
              builder: (c, s) => SleepEditScreen(
                session: model.sessions.isNotEmpty
                    ? model.sessions.first
                    : throw Exception('Нет сессий'),
                onSave: (_) => GoRouter.of(c).pop(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Трекер сна',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      darkTheme: ThemeData.dark(useMaterial3: true),
      routerConfig: router,
    );
  }
}
