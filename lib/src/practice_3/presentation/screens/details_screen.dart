import 'package:flutter/material.dart';
import '../../state/app_model.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final m = AppState.of(context);
    final id = m.selectedId;
    if (id == null) return const Center(child: Text('Выберите элемент в каталоге'));
    final it = m.items.firstWhere((e) => e.id == id);
    final fav = m.favorites.contains(id);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(it.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          Text(it.desc),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton.icon(onPressed: () => m.toggleFavorite(id), icon: Icon(fav ? Icons.favorite : Icons.favorite_border), label: Text(fav ? 'Убрать из избранного' : 'В избранное')),
              ElevatedButton.icon(onPressed: () => m.setTab(1), icon: const Icon(Icons.list), label: const Text('К списку')),
            ],
          ),
        ],
      ),
    );
  }
}
