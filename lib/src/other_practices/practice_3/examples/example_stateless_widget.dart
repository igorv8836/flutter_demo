import 'package:flutter/material.dart';
import 'widgets_demo_screen.dart';

class ExampleStatelessWidget extends StatelessWidget {
  const ExampleStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const WidgetsDemoScreen(),
    );
  }
}

