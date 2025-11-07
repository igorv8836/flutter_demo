import 'package:flutter/material.dart';
import '../../../features/sleep/model/sleep_session.dart';
import '../../utils/format.dart';

class SleepRow extends StatelessWidget {
  final SleepSession session;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  const SleepRow({super.key, required this.session, required this.onTap, required this.onDelete});
  @override
  Widget build(BuildContext context) {
    final date = fmtDate(session.start);
    final dur = session.asleep;
    return Dismissible(
      key: ValueKey(session.id),
      background: Container(color: Colors.red),
      onDismissed: (_) => onDelete(),
      child: ListTile(
        title: Text(date),
        subtitle: Text('${fmtTime(session.start)}–${session.end == null ? '…' : fmtTime(session.end!)}  •  ${fmtHm(dur)}'),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
