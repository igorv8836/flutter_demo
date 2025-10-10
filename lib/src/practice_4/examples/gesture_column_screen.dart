import 'package:flutter/material.dart';

class GestureColumnScreen extends StatefulWidget {
  const GestureColumnScreen({super.key});

  @override
  State<GestureColumnScreen> createState() => _GestureColumnScreenState();
}

class _GestureColumnScreenState extends State<GestureColumnScreen> {
  final items = List.generate(100, (index) => 'Item ${index + 1}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: items
            .map((item) => GestureDetector(
          key: ValueKey(item),
          onTap: () => setState(() => items.remove(item)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(item),
          ),
        ))
            .toList(),
      ),
    );
  }
}
