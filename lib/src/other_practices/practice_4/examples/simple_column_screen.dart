import 'package:flutter/material.dart';

class SimpleColumnScreen extends StatelessWidget {
  final items = List.generate(20, (index) => 'Item ${index + 1}');

  SimpleColumnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: items.map((item) => Text(item)).toList(),
      ),
    );
  }
}
