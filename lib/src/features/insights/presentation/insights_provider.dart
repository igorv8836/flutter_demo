import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/insights_repository_impl.dart';
import '../core/model/insight.dart';
import '../domain/usecases/get_insights_use_case.dart';

part 'insights_provider.g.dart';

final getInsightsUseCaseProvider = Provider<GetInsightsUseCase>((ref) {
  final repo = ref.watch(insightsRepositoryProvider);
  return GetInsightsUseCase(repo);
});

@riverpod
List<Insight> insights(Ref ref) {
  final useCase = ref.watch(getInsightsUseCaseProvider);
  return useCase(DateTime.now());
}
