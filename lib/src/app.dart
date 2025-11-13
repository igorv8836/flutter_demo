import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practice_2/src/features/password/password_screen.dart';

import 'features/settings/screens/settings_screen.dart';
import 'features/sleep/screens/sleep_active_screen.dart';
import 'features/sleep/screens/sleep_edit_screen.dart';
import 'features/sleep/sleep_container.dart';
import 'features/stats/screens/stats_screen.dart';

class SleepApp extends StatefulWidget {
  const SleepApp({super.key});
  @override
  State<SleepApp> createState() => _SleepAppState();
}

class _SleepAppState extends State<SleepApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(path: '/', builder: (context, state) => const PasswordScreen()),
        GoRoute(
          path: '/sleep',
          builder: (context, state) => const SleepContainer(),
        ),
        GoRoute(
          path: '/sleep/active',
          builder: (context, state) {
            final sessionId = state.extra as String?;
            if (sessionId == null) {
              throw ArgumentError('sessionId is required');
            }
            return SleepActiveScreen(sessionId: sessionId);
          },
        ),
        GoRoute(
          path: '/sleep/edit',
          builder: (context, state) {
            final sessionId = state.extra as String?;
            if (sessionId == null) {
              throw ArgumentError('sessionId is required');
            }
            return SleepEditScreen(sessionId: sessionId);
          },
        ),
        GoRoute(
          path: '/stats',
          builder: (context, state) => const StatsScreen(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsScreen(),
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
      routerConfig: _router,
    );
  }
}
