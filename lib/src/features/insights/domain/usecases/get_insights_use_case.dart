import '../insights_repository.dart';
import '../../core/model/insight.dart';

class GetInsightsUseCase {
  final InsightsRepository _repository;
  const GetInsightsUseCase(this._repository);

  List<Insight> call(DateTime now) => _repository.getInsights(now);
}
