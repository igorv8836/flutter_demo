import 'package:flutter/material.dart';

class MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final Widget? trailing;
  const MetricCard({super.key, required this.title, required this.value, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(title),
        subtitle: Text(value, style: Theme.of(context).textTheme.titleLarge),
        trailing: trailing == null
            ? null
            : ConstrainedBox(
          constraints: const BoxConstraints.tightFor(width: 96, height: 8),
          child: Align(
            alignment: Alignment.centerRight,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: SizedBox.expand(child: trailing),
            ),
          ),
        ),
      ),
    );
  }
}
