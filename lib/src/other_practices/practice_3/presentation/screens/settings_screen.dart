import 'package:flutter/material.dart';
import '../../state/app_model.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final m = AppState.of(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SwitchListTile(value: m.dark, onChanged: (_) => m.toggleTheme(), title: const Text('Тёмная тема')),
          const SizedBox(height: 12),
          ElevatedButton(onPressed: () => m.setTab(0), child: const Text('На главную')),
        ],
      ),
    );
  }
}
