import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String? imageUrl;
  final Widget? trailing;

  const MetricCard({
    super.key,
    required this.title,
    required this.value,
    this.imageUrl,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    Widget? leading;
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      leading = CachedNetworkImage(
        height: 32,
        width: 32,
        imageUrl: imageUrl!,
        placeholder: (c, _) => const SizedBox(
          width: 32, height: 32, child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
        ),
        errorWidget: (c, _, __) => const CircleAvatar(radius: 20, child: Icon(Icons.broken_image)),
      );
    }

    return Card(
      child: ListTile(
        leading: leading,
        title: Text(title),
        subtitle: Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
        trailing: trailing == null
            ? null
            : ConstrainedBox(
          constraints: const BoxConstraints.tightFor(width: 96, height: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: SizedBox.expand(child: trailing),
          ),
        ),
      ),
    );
  }
}
