// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sleep_database.dart';

// ignore_for_file: type=lint
class $SleepSessionsTable extends SleepSessions
    with TableInfo<$SleepSessionsTable, SleepSessionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SleepSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startMeta = const VerificationMeta('start');
  @override
  late final GeneratedColumn<DateTime> start = GeneratedColumn<DateTime>(
    'start',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endMeta = const VerificationMeta('end');
  @override
  late final GeneratedColumn<DateTime> end = GeneratedColumn<DateTime>(
    'end',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SleepQuality?, int> quality =
      GeneratedColumn<int>(
        'quality',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      ).withConverter<SleepQuality?>($SleepSessionsTable.$converterqualityn);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, start, end, quality, note];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sleep_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<SleepSessionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('start')) {
      context.handle(
        _startMeta,
        start.isAcceptableOrUnknown(data['start']!, _startMeta),
      );
    } else if (isInserting) {
      context.missing(_startMeta);
    }
    if (data.containsKey('end')) {
      context.handle(
        _endMeta,
        end.isAcceptableOrUnknown(data['end']!, _endMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SleepSessionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SleepSessionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      start: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start'],
      )!,
      end: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end'],
      ),
      quality: $SleepSessionsTable.$converterqualityn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}quality'],
        ),
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $SleepSessionsTable createAlias(String alias) {
    return $SleepSessionsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SleepQuality, int, int> $converterquality =
      const EnumIndexConverter<SleepQuality>(SleepQuality.values);
  static JsonTypeConverter2<SleepQuality?, int?, int?> $converterqualityn =
      JsonTypeConverter2.asNullable($converterquality);
}

class SleepSessionRow extends DataClass implements Insertable<SleepSessionRow> {
  final String id;
  final DateTime start;
  final DateTime? end;
  final SleepQuality? quality;
  final String? note;
  const SleepSessionRow({
    required this.id,
    required this.start,
    this.end,
    this.quality,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['start'] = Variable<DateTime>(start);
    if (!nullToAbsent || end != null) {
      map['end'] = Variable<DateTime>(end);
    }
    if (!nullToAbsent || quality != null) {
      map['quality'] = Variable<int>(
        $SleepSessionsTable.$converterqualityn.toSql(quality),
      );
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  SleepSessionsCompanion toCompanion(bool nullToAbsent) {
    return SleepSessionsCompanion(
      id: Value(id),
      start: Value(start),
      end: end == null && nullToAbsent ? const Value.absent() : Value(end),
      quality: quality == null && nullToAbsent
          ? const Value.absent()
          : Value(quality),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory SleepSessionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SleepSessionRow(
      id: serializer.fromJson<String>(json['id']),
      start: serializer.fromJson<DateTime>(json['start']),
      end: serializer.fromJson<DateTime?>(json['end']),
      quality: $SleepSessionsTable.$converterqualityn.fromJson(
        serializer.fromJson<int?>(json['quality']),
      ),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'start': serializer.toJson<DateTime>(start),
      'end': serializer.toJson<DateTime?>(end),
      'quality': serializer.toJson<int?>(
        $SleepSessionsTable.$converterqualityn.toJson(quality),
      ),
      'note': serializer.toJson<String?>(note),
    };
  }

  SleepSessionRow copyWith({
    String? id,
    DateTime? start,
    Value<DateTime?> end = const Value.absent(),
    Value<SleepQuality?> quality = const Value.absent(),
    Value<String?> note = const Value.absent(),
  }) => SleepSessionRow(
    id: id ?? this.id,
    start: start ?? this.start,
    end: end.present ? end.value : this.end,
    quality: quality.present ? quality.value : this.quality,
    note: note.present ? note.value : this.note,
  );
  SleepSessionRow copyWithCompanion(SleepSessionsCompanion data) {
    return SleepSessionRow(
      id: data.id.present ? data.id.value : this.id,
      start: data.start.present ? data.start.value : this.start,
      end: data.end.present ? data.end.value : this.end,
      quality: data.quality.present ? data.quality.value : this.quality,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SleepSessionRow(')
          ..write('id: $id, ')
          ..write('start: $start, ')
          ..write('end: $end, ')
          ..write('quality: $quality, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, start, end, quality, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SleepSessionRow &&
          other.id == this.id &&
          other.start == this.start &&
          other.end == this.end &&
          other.quality == this.quality &&
          other.note == this.note);
}

class SleepSessionsCompanion extends UpdateCompanion<SleepSessionRow> {
  final Value<String> id;
  final Value<DateTime> start;
  final Value<DateTime?> end;
  final Value<SleepQuality?> quality;
  final Value<String?> note;
  final Value<int> rowid;
  const SleepSessionsCompanion({
    this.id = const Value.absent(),
    this.start = const Value.absent(),
    this.end = const Value.absent(),
    this.quality = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SleepSessionsCompanion.insert({
    required String id,
    required DateTime start,
    this.end = const Value.absent(),
    this.quality = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       start = Value(start);
  static Insertable<SleepSessionRow> custom({
    Expression<String>? id,
    Expression<DateTime>? start,
    Expression<DateTime>? end,
    Expression<int>? quality,
    Expression<String>? note,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (start != null) 'start': start,
      if (end != null) 'end': end,
      if (quality != null) 'quality': quality,
      if (note != null) 'note': note,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SleepSessionsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? start,
    Value<DateTime?>? end,
    Value<SleepQuality?>? quality,
    Value<String?>? note,
    Value<int>? rowid,
  }) {
    return SleepSessionsCompanion(
      id: id ?? this.id,
      start: start ?? this.start,
      end: end ?? this.end,
      quality: quality ?? this.quality,
      note: note ?? this.note,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (start.present) {
      map['start'] = Variable<DateTime>(start.value);
    }
    if (end.present) {
      map['end'] = Variable<DateTime>(end.value);
    }
    if (quality.present) {
      map['quality'] = Variable<int>(
        $SleepSessionsTable.$converterqualityn.toSql(quality.value),
      );
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SleepSessionsCompanion(')
          ..write('id: $id, ')
          ..write('start: $start, ')
          ..write('end: $end, ')
          ..write('quality: $quality, ')
          ..write('note: $note, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AwakeningsTable extends Awakenings
    with TableInfo<$AwakeningsTable, AwakeningRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AwakeningsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES sleep_sessions (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _startMeta = const VerificationMeta('start');
  @override
  late final GeneratedColumn<DateTime> start = GeneratedColumn<DateTime>(
    'start',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endMeta = const VerificationMeta('end');
  @override
  late final GeneratedColumn<DateTime> end = GeneratedColumn<DateTime>(
    'end',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, sessionId, start, end, position];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'awakenings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AwakeningRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('start')) {
      context.handle(
        _startMeta,
        start.isAcceptableOrUnknown(data['start']!, _startMeta),
      );
    } else if (isInserting) {
      context.missing(_startMeta);
    }
    if (data.containsKey('end')) {
      context.handle(
        _endMeta,
        end.isAcceptableOrUnknown(data['end']!, _endMeta),
      );
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AwakeningRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AwakeningRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      start: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start'],
      )!,
      end: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end'],
      ),
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
    );
  }

  @override
  $AwakeningsTable createAlias(String alias) {
    return $AwakeningsTable(attachedDatabase, alias);
  }
}

class AwakeningRow extends DataClass implements Insertable<AwakeningRow> {
  final int id;
  final String sessionId;
  final DateTime start;
  final DateTime? end;
  final int position;
  const AwakeningRow({
    required this.id,
    required this.sessionId,
    required this.start,
    this.end,
    required this.position,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['session_id'] = Variable<String>(sessionId);
    map['start'] = Variable<DateTime>(start);
    if (!nullToAbsent || end != null) {
      map['end'] = Variable<DateTime>(end);
    }
    map['position'] = Variable<int>(position);
    return map;
  }

  AwakeningsCompanion toCompanion(bool nullToAbsent) {
    return AwakeningsCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      start: Value(start),
      end: end == null && nullToAbsent ? const Value.absent() : Value(end),
      position: Value(position),
    );
  }

  factory AwakeningRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AwakeningRow(
      id: serializer.fromJson<int>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      start: serializer.fromJson<DateTime>(json['start']),
      end: serializer.fromJson<DateTime?>(json['end']),
      position: serializer.fromJson<int>(json['position']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'start': serializer.toJson<DateTime>(start),
      'end': serializer.toJson<DateTime?>(end),
      'position': serializer.toJson<int>(position),
    };
  }

  AwakeningRow copyWith({
    int? id,
    String? sessionId,
    DateTime? start,
    Value<DateTime?> end = const Value.absent(),
    int? position,
  }) => AwakeningRow(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    start: start ?? this.start,
    end: end.present ? end.value : this.end,
    position: position ?? this.position,
  );
  AwakeningRow copyWithCompanion(AwakeningsCompanion data) {
    return AwakeningRow(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      start: data.start.present ? data.start.value : this.start,
      end: data.end.present ? data.end.value : this.end,
      position: data.position.present ? data.position.value : this.position,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AwakeningRow(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('start: $start, ')
          ..write('end: $end, ')
          ..write('position: $position')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sessionId, start, end, position);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AwakeningRow &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.start == this.start &&
          other.end == this.end &&
          other.position == this.position);
}

class AwakeningsCompanion extends UpdateCompanion<AwakeningRow> {
  final Value<int> id;
  final Value<String> sessionId;
  final Value<DateTime> start;
  final Value<DateTime?> end;
  final Value<int> position;
  const AwakeningsCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.start = const Value.absent(),
    this.end = const Value.absent(),
    this.position = const Value.absent(),
  });
  AwakeningsCompanion.insert({
    this.id = const Value.absent(),
    required String sessionId,
    required DateTime start,
    this.end = const Value.absent(),
    required int position,
  }) : sessionId = Value(sessionId),
       start = Value(start),
       position = Value(position);
  static Insertable<AwakeningRow> custom({
    Expression<int>? id,
    Expression<String>? sessionId,
    Expression<DateTime>? start,
    Expression<DateTime>? end,
    Expression<int>? position,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (start != null) 'start': start,
      if (end != null) 'end': end,
      if (position != null) 'position': position,
    });
  }

  AwakeningsCompanion copyWith({
    Value<int>? id,
    Value<String>? sessionId,
    Value<DateTime>? start,
    Value<DateTime?>? end,
    Value<int>? position,
  }) {
    return AwakeningsCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      start: start ?? this.start,
      end: end ?? this.end,
      position: position ?? this.position,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (start.present) {
      map['start'] = Variable<DateTime>(start.value);
    }
    if (end.present) {
      map['end'] = Variable<DateTime>(end.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AwakeningsCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('start: $start, ')
          ..write('end: $end, ')
          ..write('position: $position')
          ..write(')'))
        .toString();
  }
}

abstract class _$SleepDatabase extends GeneratedDatabase {
  _$SleepDatabase(QueryExecutor e) : super(e);
  $SleepDatabaseManager get managers => $SleepDatabaseManager(this);
  late final $SleepSessionsTable sleepSessions = $SleepSessionsTable(this);
  late final $AwakeningsTable awakenings = $AwakeningsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    sleepSessions,
    awakenings,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'sleep_sessions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('awakenings', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$SleepSessionsTableCreateCompanionBuilder =
    SleepSessionsCompanion Function({
      required String id,
      required DateTime start,
      Value<DateTime?> end,
      Value<SleepQuality?> quality,
      Value<String?> note,
      Value<int> rowid,
    });
typedef $$SleepSessionsTableUpdateCompanionBuilder =
    SleepSessionsCompanion Function({
      Value<String> id,
      Value<DateTime> start,
      Value<DateTime?> end,
      Value<SleepQuality?> quality,
      Value<String?> note,
      Value<int> rowid,
    });

final class $$SleepSessionsTableReferences
    extends
        BaseReferences<_$SleepDatabase, $SleepSessionsTable, SleepSessionRow> {
  $$SleepSessionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$AwakeningsTable, List<AwakeningRow>>
  _awakeningsRefsTable(_$SleepDatabase db) => MultiTypedResultKey.fromTable(
    db.awakenings,
    aliasName: $_aliasNameGenerator(
      db.sleepSessions.id,
      db.awakenings.sessionId,
    ),
  );

  $$AwakeningsTableProcessedTableManager get awakeningsRefs {
    final manager = $$AwakeningsTableTableManager(
      $_db,
      $_db.awakenings,
    ).filter((f) => f.sessionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_awakeningsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SleepSessionsTableFilterComposer
    extends Composer<_$SleepDatabase, $SleepSessionsTable> {
  $$SleepSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get start => $composableBuilder(
    column: $table.start,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get end => $composableBuilder(
    column: $table.end,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SleepQuality?, SleepQuality, int>
  get quality => $composableBuilder(
    column: $table.quality,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> awakeningsRefs(
    Expression<bool> Function($$AwakeningsTableFilterComposer f) f,
  ) {
    final $$AwakeningsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.awakenings,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AwakeningsTableFilterComposer(
            $db: $db,
            $table: $db.awakenings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SleepSessionsTableOrderingComposer
    extends Composer<_$SleepDatabase, $SleepSessionsTable> {
  $$SleepSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get start => $composableBuilder(
    column: $table.start,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get end => $composableBuilder(
    column: $table.end,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quality => $composableBuilder(
    column: $table.quality,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SleepSessionsTableAnnotationComposer
    extends Composer<_$SleepDatabase, $SleepSessionsTable> {
  $$SleepSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get start =>
      $composableBuilder(column: $table.start, builder: (column) => column);

  GeneratedColumn<DateTime> get end =>
      $composableBuilder(column: $table.end, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SleepQuality?, int> get quality =>
      $composableBuilder(column: $table.quality, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  Expression<T> awakeningsRefs<T extends Object>(
    Expression<T> Function($$AwakeningsTableAnnotationComposer a) f,
  ) {
    final $$AwakeningsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.awakenings,
      getReferencedColumn: (t) => t.sessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AwakeningsTableAnnotationComposer(
            $db: $db,
            $table: $db.awakenings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SleepSessionsTableTableManager
    extends
        RootTableManager<
          _$SleepDatabase,
          $SleepSessionsTable,
          SleepSessionRow,
          $$SleepSessionsTableFilterComposer,
          $$SleepSessionsTableOrderingComposer,
          $$SleepSessionsTableAnnotationComposer,
          $$SleepSessionsTableCreateCompanionBuilder,
          $$SleepSessionsTableUpdateCompanionBuilder,
          (SleepSessionRow, $$SleepSessionsTableReferences),
          SleepSessionRow,
          PrefetchHooks Function({bool awakeningsRefs})
        > {
  $$SleepSessionsTableTableManager(
    _$SleepDatabase db,
    $SleepSessionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SleepSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SleepSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SleepSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> start = const Value.absent(),
                Value<DateTime?> end = const Value.absent(),
                Value<SleepQuality?> quality = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SleepSessionsCompanion(
                id: id,
                start: start,
                end: end,
                quality: quality,
                note: note,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime start,
                Value<DateTime?> end = const Value.absent(),
                Value<SleepQuality?> quality = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SleepSessionsCompanion.insert(
                id: id,
                start: start,
                end: end,
                quality: quality,
                note: note,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SleepSessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({awakeningsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (awakeningsRefs) db.awakenings],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (awakeningsRefs)
                    await $_getPrefetchedData<
                      SleepSessionRow,
                      $SleepSessionsTable,
                      AwakeningRow
                    >(
                      currentTable: table,
                      referencedTable: $$SleepSessionsTableReferences
                          ._awakeningsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$SleepSessionsTableReferences(
                            db,
                            table,
                            p0,
                          ).awakeningsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.sessionId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SleepSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$SleepDatabase,
      $SleepSessionsTable,
      SleepSessionRow,
      $$SleepSessionsTableFilterComposer,
      $$SleepSessionsTableOrderingComposer,
      $$SleepSessionsTableAnnotationComposer,
      $$SleepSessionsTableCreateCompanionBuilder,
      $$SleepSessionsTableUpdateCompanionBuilder,
      (SleepSessionRow, $$SleepSessionsTableReferences),
      SleepSessionRow,
      PrefetchHooks Function({bool awakeningsRefs})
    >;
typedef $$AwakeningsTableCreateCompanionBuilder =
    AwakeningsCompanion Function({
      Value<int> id,
      required String sessionId,
      required DateTime start,
      Value<DateTime?> end,
      required int position,
    });
typedef $$AwakeningsTableUpdateCompanionBuilder =
    AwakeningsCompanion Function({
      Value<int> id,
      Value<String> sessionId,
      Value<DateTime> start,
      Value<DateTime?> end,
      Value<int> position,
    });

final class $$AwakeningsTableReferences
    extends BaseReferences<_$SleepDatabase, $AwakeningsTable, AwakeningRow> {
  $$AwakeningsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SleepSessionsTable _sessionIdTable(_$SleepDatabase db) =>
      db.sleepSessions.createAlias(
        $_aliasNameGenerator(db.awakenings.sessionId, db.sleepSessions.id),
      );

  $$SleepSessionsTableProcessedTableManager get sessionId {
    final $_column = $_itemColumn<String>('session_id')!;

    final manager = $$SleepSessionsTableTableManager(
      $_db,
      $_db.sleepSessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AwakeningsTableFilterComposer
    extends Composer<_$SleepDatabase, $AwakeningsTable> {
  $$AwakeningsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get start => $composableBuilder(
    column: $table.start,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get end => $composableBuilder(
    column: $table.end,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  $$SleepSessionsTableFilterComposer get sessionId {
    final $$SleepSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sleepSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SleepSessionsTableFilterComposer(
            $db: $db,
            $table: $db.sleepSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AwakeningsTableOrderingComposer
    extends Composer<_$SleepDatabase, $AwakeningsTable> {
  $$AwakeningsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get start => $composableBuilder(
    column: $table.start,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get end => $composableBuilder(
    column: $table.end,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  $$SleepSessionsTableOrderingComposer get sessionId {
    final $$SleepSessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sleepSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SleepSessionsTableOrderingComposer(
            $db: $db,
            $table: $db.sleepSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AwakeningsTableAnnotationComposer
    extends Composer<_$SleepDatabase, $AwakeningsTable> {
  $$AwakeningsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get start =>
      $composableBuilder(column: $table.start, builder: (column) => column);

  GeneratedColumn<DateTime> get end =>
      $composableBuilder(column: $table.end, builder: (column) => column);

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  $$SleepSessionsTableAnnotationComposer get sessionId {
    final $$SleepSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.sessionId,
      referencedTable: $db.sleepSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SleepSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.sleepSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AwakeningsTableTableManager
    extends
        RootTableManager<
          _$SleepDatabase,
          $AwakeningsTable,
          AwakeningRow,
          $$AwakeningsTableFilterComposer,
          $$AwakeningsTableOrderingComposer,
          $$AwakeningsTableAnnotationComposer,
          $$AwakeningsTableCreateCompanionBuilder,
          $$AwakeningsTableUpdateCompanionBuilder,
          (AwakeningRow, $$AwakeningsTableReferences),
          AwakeningRow,
          PrefetchHooks Function({bool sessionId})
        > {
  $$AwakeningsTableTableManager(_$SleepDatabase db, $AwakeningsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AwakeningsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AwakeningsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AwakeningsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<DateTime> start = const Value.absent(),
                Value<DateTime?> end = const Value.absent(),
                Value<int> position = const Value.absent(),
              }) => AwakeningsCompanion(
                id: id,
                sessionId: sessionId,
                start: start,
                end: end,
                position: position,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String sessionId,
                required DateTime start,
                Value<DateTime?> end = const Value.absent(),
                required int position,
              }) => AwakeningsCompanion.insert(
                id: id,
                sessionId: sessionId,
                start: start,
                end: end,
                position: position,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AwakeningsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sessionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (sessionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.sessionId,
                                referencedTable: $$AwakeningsTableReferences
                                    ._sessionIdTable(db),
                                referencedColumn: $$AwakeningsTableReferences
                                    ._sessionIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AwakeningsTableProcessedTableManager =
    ProcessedTableManager<
      _$SleepDatabase,
      $AwakeningsTable,
      AwakeningRow,
      $$AwakeningsTableFilterComposer,
      $$AwakeningsTableOrderingComposer,
      $$AwakeningsTableAnnotationComposer,
      $$AwakeningsTableCreateCompanionBuilder,
      $$AwakeningsTableUpdateCompanionBuilder,
      (AwakeningRow, $$AwakeningsTableReferences),
      AwakeningRow,
      PrefetchHooks Function({bool sessionId})
    >;

class $SleepDatabaseManager {
  final _$SleepDatabase _db;
  $SleepDatabaseManager(this._db);
  $$SleepSessionsTableTableManager get sleepSessions =>
      $$SleepSessionsTableTableManager(_db, _db.sleepSessions);
  $$AwakeningsTableTableManager get awakenings =>
      $$AwakeningsTableTableManager(_db, _db.awakenings);
}
