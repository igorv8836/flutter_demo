import 'package:flutter/material.dart';
import '../models/item.dart';

class AppModel extends ChangeNotifier {
  int tab = 0;
  bool dark = false;
  final items = List.generate(20, (i) => Item(i, 'Элемент #$i', 'Описание элемента #$i'));
  final favorites = <int>{};
  int? selectedId;

  void setTab(int i) { tab = i; notifyListeners(); }
  void toggleTheme() { dark = !dark; notifyListeners(); }
  void selectItem(int id) { selectedId = id; notifyListeners(); }
  void toggleFavorite(int id) { favorites.contains(id) ? favorites.remove(id) : favorites.add(id); notifyListeners(); }
}

class AppState extends InheritedNotifier<AppModel> {
  const AppState({super.key, required AppModel super.notifier, required super.child});
  static AppModel of(BuildContext context) => (context.dependOnInheritedWidgetOfExactType<AppState>()!).notifier!;
}
