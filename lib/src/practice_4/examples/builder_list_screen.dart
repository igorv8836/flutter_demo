import 'package:flutter/material.dart';

class BuilderListScreen extends StatelessWidget {
  final items = List.generate(100, (index) => 'Item ${index + 1}');

  BuilderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (_, position) => Text(items[position]),
        itemCount: items.length,
      ),
    );
  }

}
