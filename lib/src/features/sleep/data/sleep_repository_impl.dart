import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/sleep_repository.dart';
import '../core/model/sleep_session.dart';
import 'sleep_data_source.dart';
import 'sleep_local_data_source.dart';

final sleepRepositoryProvider = Provider<SleepRepository>((ref) {
  return SleepRepositoryImpl();
});

class SleepRepositoryImpl implements SleepRepository {
  SleepRepositoryImpl({SleepDataSource? dataSource}) : _local = dataSource ?? SleepLocalDataSource();

  final SleepDataSource _local;

  @override
  List<SleepSession> readSessions() => _local.readSessions();

  @override
  void writeSessions(List<SleepSession> sessions) => _local.writeSessions(sessions);
}
