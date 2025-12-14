import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../settings_form.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(settingsFormProvider);
    final notifier = ref.read(settingsFormProvider.notifier);

    Future<void> pickTarget() async {
      final duration = form.targetDuration;
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: duration.inHours, minute: duration.inMinutes.remainder(60)),
      );
      if (time != null) {
        notifier.updateTarget(Duration(hours: time.hour, minutes: time.minute));
      }
    }

    Future<void> pickBedtime() async {
      final time = await showTimePicker(context: context, initialTime: form.targetBedtime);
      if (time != null) notifier.updateBedtime(time);
    }

    void save() {
      notifier.save();
      context.pop();
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Настройки'), actions: [IconButton(onPressed: save, icon: const Icon(Icons.check))]),
      body: ListView(
        children: [
          CachedNetworkImage(
            imageUrl: 'https://mir-s3-cdn-cf.behance.net/e4f6c8c8468adcb8a48dbf6954bf107f/e8abd2ef-973f-407a-a0d7-11e1f228035a_rwc_0x681x1920x268x1920.jpg?h=341110f16f7600679ef49cb7b2cf7856',
            height: 180,
            fit: BoxFit.cover,
            placeholder: (c, _) => const SizedBox(height: 180, child: Center(child: CircularProgressIndicator())),
            errorWidget: (c, _, __) => const SizedBox(height: 180, child: Center(child: Icon(Icons.broken_image))),
          ),
          ListTile(
            title: const Text('Целевая длительность'),
            subtitle: Text('${form.targetDuration.inHours} ч ${form.targetDuration.inMinutes.remainder(60)} мин'),
            onTap: pickTarget,
          ),
          ListTile(
            title: const Text('Желаемое время отбоя'),
            subtitle: Text(
              '${form.targetBedtime.hour.toString().padLeft(2, '0')}:${form.targetBedtime.minute.toString().padLeft(2, '0')}',
            ),
            onTap: pickBedtime,
          ),
          SwitchListTile(
            title: const Text('Тёмная тема'),
            subtitle: const Text('Переключить оформление приложения'),
            value: form.useDarkTheme,
            onChanged: notifier.updateUseDarkTheme,
          ),
        ],
      ),
    );
  }
}
