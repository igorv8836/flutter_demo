import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practice_2/src/features/password/password_screen.dart';

import 'app_model.dart';
import 'features/settings/model/settings.dart';
import 'features/settings/screens/settings_screen.dart';
import 'features/sleep/model/sleep_session.dart';
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
  late final AppModel model;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    model = AppModel();
    _router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const PasswordScreen(),
        ),
        GoRoute(
          path: '/sleep',
          builder: (context, state) {
            final extra = state.extra;
            final AppModel m = extra is AppModel ? extra : model;
            return SleepContainer(model: m);
          },
        ),
        GoRoute(
          path: '/sleep/active',
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>;
            final SleepSession session = extra['session'] as SleepSession;
            final VoidCallback onAwakening = extra['onAwakening'] as VoidCallback;
            final VoidCallback onFinish = extra['onFinish'] as VoidCallback;
            return SleepActiveScreen(session: session, onAwakening: onAwakening, onFinish: onFinish);
          },
        ),
        GoRoute(
          path: '/sleep/edit',
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>;
            final SleepSession session = extra['session'] as SleepSession;
            final void Function(SleepSession) onSave = extra['onSave'] as void Function(SleepSession);
            return SleepEditScreen(session: session, onSave: onSave);
          },
        ),
        GoRoute(
          path: '/stats',
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>;
            final List<SleepSession> sessions = extra['sessions'] as List<SleepSession>;
            final Settings settings = extra['settings'] as Settings;
            final VoidCallback? onClose = extra['onClose'] as VoidCallback?;
            return StatsScreen(sessions: sessions, settings: settings, onClose: onClose);
          },
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>;
            final Settings initial = extra['initial'] as Settings;
            final void Function(Settings) onSave = extra['onSave'] as void Function(Settings);
            return SettingsScreen(initial: initial, onSave: onSave);
          },
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
