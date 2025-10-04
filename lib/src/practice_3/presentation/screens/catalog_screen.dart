import 'package:flutter/material.dart';
import '../../state/app_model.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final m = AppState.of(context);
    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: m.items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (c, i) {
        final it = m.items[i];
        final fav = m.favorites.contains(it.id);
        return ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          tileColor: Theme.of(c).colorScheme.surfaceContainerHighest,
          title: Text(it.title),
          subtitle: Text(it.desc),
          trailing: IconButton(icon: Icon(fav ? Icons.favorite : Icons.favorite_border), onPressed: () => m.toggleFavorite(it.id)),
          onTap: () {
            m.selectItem(it.id);
            m.setTab(2);
          },
        );
      },
    );
  }
}
