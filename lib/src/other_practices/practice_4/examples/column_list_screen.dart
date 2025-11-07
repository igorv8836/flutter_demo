import 'package:flutter/material.dart';

class ColumnListScreen extends StatelessWidget {
  final items = List.generate(100, (index) => 'Item ${index + 1}');

  ColumnListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.map((item) => Text(item)).toList(),
        ),
      ),
    );
  }
}
