import 'package:flutter/material.dart';
import '../../state/app_model.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final m = AppState.of(context);
    final favItems = m.items.where((e) => m.favorites.contains(e.id)).toList();
    if (favItems.isEmpty) return const Center(child: Text('Пусто'));
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: favItems.length,
      itemBuilder: (c, i) {
        final it = favItems[i];
        return Card(
          child: ListTile(
            title: Text(it.title),
            subtitle: Text(it.desc),
            trailing: IconButton(icon: const Icon(Icons.remove_circle_outline), onPressed: () => m.toggleFavorite(it.id)),
            onTap: () { m.selectItem(it.id); m.setTab(2); },
          ),
        );
      },
    );
  }
}
