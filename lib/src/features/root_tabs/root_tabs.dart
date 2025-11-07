import 'package:flutter/material.dart';
import '../../app_model.dart';
import '../sleep/sleep_container.dart';
import '../stats/screens/stats_screen.dart';
import '../settings/screens/settings_screen.dart';

class RootTabs extends StatefulWidget {
  final AppModel model;
  const RootTabs({super.key, required this.model});

  @override
  State<RootTabs> createState() => _RootTabsState();
}

class _RootTabsState extends State<RootTabs> {
  int _index = 0;

  void _openTab(int i) {
    if (i == _index) return;
    setState(() => _index = i);

    Widget page;
    if (i == 0) {
      page = SleepContainer(model: widget.model);
    } else if (i == 1) {
      page = StatsScreen(
        sessions: widget.model.sessions,
        settings: widget.model.settings,
      );
    } else {
      page = SettingsScreen(
        initial: widget.model.settings,
        onSave: (v) {
          widget.model.settings = v;
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Сохранено')));
        },
      );
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget currentPage;
    if (_index == 0) {
      currentPage = SleepContainer(model: widget.model);
    } else if (_index == 1) {
      currentPage = StatsScreen(
        sessions: widget.model.sessions,
        settings: widget.model.settings,
      );
    } else {
      currentPage = SettingsScreen(
        initial: widget.model.settings,
        onSave: (v) {
          widget.model.settings = v;
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Сохранено')));
        },
      );
    }

    return Scaffold(
      body: currentPage,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: _openTab,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.nights_stay), label: 'Главная'),
          NavigationDestination(icon: Icon(Icons.insights), label: 'Статистика'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Настройки'),
        ],
      ),
    );
  }
}
