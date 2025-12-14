import 'dart:async';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../core/model/awakening.dart';
import '../core/model/sleep_session.dart';

part 'sleep_database.g.dart';

@DataClassName('SleepSessionRow')
class SleepSessions extends Table {
  TextColumn get id => text()();
  DateTimeColumn get start => dateTime()();
  DateTimeColumn get end => dateTime().nullable()();
  IntColumn get quality => intEnum<SleepQuality>().nullable()();
  TextColumn get note => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('AwakeningRow')
class Awakenings extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get sessionId => text().references(SleepSessions, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get start => dateTime()();
  DateTimeColumn get end => dateTime().nullable()();
  IntColumn get position => integer()();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'sleep_tracker.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

@DriftDatabase(tables: [SleepSessions, Awakenings])
class SleepDatabase extends _$SleepDatabase {
  SleepDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<void> replaceAllSessions(List<SleepSession> sessions) async {
    await transaction(() async {
      await delete(awakenings).go();
      await delete(sleepSessions).go();
      for (final session in sessions) {
        await into(sleepSessions).insert(
          SleepSessionsCompanion.insert(
            id: session.id,
            start: session.start,
            end: Value(session.end),
            quality: Value(session.quality),
            note: Value(session.note),
          ),
        );
        for (var i = 0; i < session.awakenings.length; i++) {
          final a = session.awakenings[i];
          await into(awakenings).insert(
            AwakeningsCompanion.insert(
              sessionId: session.id,
              start: a.start,
              end: Value(a.end),
              position: i,
            ),
          );
        }
      }
    });
  }

  Future<List<SleepSession>> loadSessions() async {
    final List<SleepSessionRow> sessionRows = await select(sleepSessions).get();
    final List<AwakeningRow> awakeningRows = await select(awakenings).get();
    final awakeningsBySession = <String, List<Awakening>>{};
    for (final row in awakeningRows) {
      awakeningsBySession.putIfAbsent(row.sessionId, () => []);
      awakeningsBySession[row.sessionId]!.add(Awakening(start: row.start, end: row.end));
    }
    final sessions = sessionRows.map((row) {
      final awakings = awakeningsBySession[row.id] ?? [];
      awakings.sort((a, b) => a.start.compareTo(b.start));
      return SleepSession(
        id: row.id,
        start: row.start,
        end: row.end,
        awakenings: awakings,
        quality: row.quality,
        note: row.note,
      );
    }).toList();
    sessions.sort((a, b) => b.start.compareTo(a.start));
    return sessions;
  }
}
