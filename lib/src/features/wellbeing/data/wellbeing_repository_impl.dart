import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/wellbeing_repository.dart';
import '../domain/wellbeing_state.dart';
import 'wellbeing_data_source.dart';
import 'wellbeing_local_data_source.dart';

final wellbeingRepositoryProvider = Provider<WellbeingRepository>((ref) {
  return WellbeingRepositoryImpl();
});

class WellbeingRepositoryImpl implements WellbeingRepository {
  WellbeingRepositoryImpl({WellbeingDataSource? dataSource}) : _local = dataSource ?? WellbeingLocalDataSource();

  final WellbeingDataSource _local;

  @override
  WellbeingState read() => _local.read();

  @override
  void write(WellbeingState state) => _local.write(state);
}
