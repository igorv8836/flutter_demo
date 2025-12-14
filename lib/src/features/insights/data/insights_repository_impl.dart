import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/insights_repository.dart';
import '../core/model/insight.dart';
import 'insights_data_source.dart';
import 'insights_local_data_source.dart';

final insightsRepositoryProvider = Provider<InsightsRepository>((ref) {
  return InsightsRepositoryImpl();
});

class InsightsRepositoryImpl implements InsightsRepository {
  InsightsRepositoryImpl({InsightsDataSource? dataSource}) : _local = dataSource ?? InsightsLocalDataSource();

  final InsightsDataSource _local;

  @override
  List<Insight> getInsights(DateTime now) => _local.getInsights(now);
}
