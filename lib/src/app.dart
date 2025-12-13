import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'features/auth/screens/login_screen.dart';
import 'features/auth/screens/register_screen.dart';
import 'features/goals/screens/goals_screen.dart';
import 'features/insights/screens/insights_screen.dart';
import 'features/profile/screens/profile_screen.dart';
import 'features/schedule/screens/schedule_planner_screen.dart';
import 'features/settings/domain/settings_controller.dart';
import 'features/settings/screens/settings_screen.dart';
import 'features/sleep/screens/sleep_active_screen.dart';
import 'features/sleep/screens/sleep_edit_screen.dart';
import 'features/sleep/sleep_container.dart';
import 'features/stats/screens/stats_screen.dart';
import 'features/wellbeing/screens/stress_mood_screen.dart';

class SleepApp extends ConsumerStatefulWidget {
  const SleepApp({super.key});
  @override
  ConsumerState<SleepApp> createState() => _SleepAppState();
}

class _SleepAppState extends ConsumerState<SleepApp> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(path: '/', builder: (context, state) => const LoginScreen()),
        GoRoute(path: '/register', builder: (context, state) => const RegisterScreen()),
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
        GoRoute(
          path: '/goals',
          builder: (context, state) => const GoalsScreen(),
        ),
        GoRoute(
          path: '/planner',
          builder: (context, state) => const SchedulePlannerScreen(),
        ),
        GoRoute(
          path: '/insights',
          builder: (context, state) => const InsightsScreen(),
        ),
        GoRoute(
          path: '/wellbeing',
          builder: (context, state) => const StressMoodScreen(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsControllerProvider);
    final themeMode = settings.useDarkTheme ? ThemeMode.dark : ThemeMode.light;
    return MaterialApp.router(
      title: 'Трекер сна',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.dark,
      ),
      themeMode: themeMode,
      routerConfig: _router,
    );
  }
}
