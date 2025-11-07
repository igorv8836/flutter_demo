import 'package:flutter/material.dart';
import '../../state/app_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final m = AppState.of(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Добро пожаловать', textAlign: TextAlign.center, style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.indigoAccent.withOpacity(.1), borderRadius: BorderRadius.circular(12)),
            child: Text('Всего элементов: ${m.items.length}\nВ избранном: ${m.favorites.length}'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: () => m.setTab(1), child: const Text('Перейти в каталог')),
          const SizedBox(height: 8),
          ElevatedButton(onPressed: () => m.setTab(3), child: const Text('Открыть избранное')),
        ],
      ),
    );
  }
}
