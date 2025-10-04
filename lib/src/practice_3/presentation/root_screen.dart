import 'package:flutter/material.dart';
import '../state/app_model.dart';
import 'screens/home_screen.dart';
import 'screens/catalog_screen.dart';
import 'screens/details_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/settings_screen.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final m = AppState.of(context);
    final tabs = const [HomeScreen(), CatalogScreen(), DetailsScreen(), FavoritesScreen(), SettingsScreen()];
    return Scaffold(
      appBar: AppBar(title: const Text('Васильев Игорь ИКБО-06-22')),
      body: tabs[m.tab],
      bottomNavigationBar: NavigationBar(
        selectedIndex: m.tab,
        onDestinationSelected: m.setTab,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Главная'),
          NavigationDestination(icon: Icon(Icons.list_alt_outlined), selectedIcon: Icon(Icons.list), label: 'Каталог'),
          NavigationDestination(icon: Icon(Icons.info_outline), selectedIcon: Icon(Icons.info), label: 'Детали'),
          NavigationDestination(icon: Icon(Icons.favorite_border), selectedIcon: Icon(Icons.favorite), label: 'Избранное'),
          NavigationDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings), label: 'Настройки'),
        ],
      ),
    );
  }
}
