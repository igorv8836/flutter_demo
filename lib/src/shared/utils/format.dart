import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final _dfDate = DateFormat('dd.MM.yyyy');
final _dfTime = DateFormat('HH:mm');

String fmtDate(DateTime dt) => _dfDate.format(dt);
String fmtTime(DateTime dt) => _dfTime.format(dt);
String fmtHm(Duration d) {
  final h = d.inHours;
  final m = d.inMinutes.remainder(60);
  return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}';
}

String fmtTimeOfDay(TimeOfDay t) => '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
