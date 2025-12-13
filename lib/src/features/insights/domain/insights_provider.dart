import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/insights_local_data_source.dart';
import '../model/insight.dart';

part 'insights_provider.g.dart';

final insightsDataSourceProvider = Provider((ref) => InsightsLocalDataSource());

@riverpod
List<Insight> insights(Ref ref) {
  final source = ref.watch(insightsDataSourceProvider);
  return source.getInsights(DateTime.now());
}
