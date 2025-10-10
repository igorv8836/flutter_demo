import 'package:flutter/material.dart';

class SeparatedListScreen extends StatelessWidget {
  final items = List.generate(100, (index) => 'Item ${index + 1}');

  SeparatedListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemBuilder: (_, position) => Text(items[position]),
        separatorBuilder: (_, __) => const Divider(),
        itemCount: items.length,
      ),
    );
  }

}