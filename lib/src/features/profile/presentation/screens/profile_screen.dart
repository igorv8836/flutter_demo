import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../auth/presentation/auth_controller.dart';
import '../../domain/profile_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
        leading: IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.arrow_back)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: Text(profile.name),
              subtitle: Text(profile.email),
              trailing: Chip(
                label: Text(profile.isAuthenticated ? 'Онлайн' : 'Гость'),
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text('Фокус сегодня', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ...profile.focus.map((f) => _InfoTile(icon: _iconFor(f.icon), title: f.title, subtitle: f.subtitle)),
          const SizedBox(height: 12),
          const Text('Быстрые действия', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ...profile.shortcuts.map(
                (s) => FilledButton.tonalIcon(
                  onPressed: () => context.push(s.route),
                  icon: Icon(_iconFor(s.icon)),
                  label: Text(s.label),
                ),
              ),
              FilledButton.tonalIcon(
                onPressed: () {
                  ref.read(authControllerProvider.notifier).logout();
                  context.go('/');
                },
                icon: const Icon(Icons.logout),
                label: const Text('Выйти'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  const _InfoTile({required this.icon, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          child: Icon(icon, color: Theme.of(context).colorScheme.onSecondaryContainer),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}

IconData _iconFor(String code) {
  switch (code) {
    case 'heart':
      return Icons.favorite;
    case 'shield':
      return Icons.shield_moon;
    case 'support':
      return Icons.handshake;
    case 'settings':
      return Icons.settings;
    case 'light':
      return Icons.lightbulb;
    case 'mood':
      return Icons.emoji_emotions;
    default:
      return Icons.circle;
  }
}
