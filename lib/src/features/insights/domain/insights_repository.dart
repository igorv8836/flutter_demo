import '../core/model/insight.dart';

abstract class InsightsRepository {
  List<Insight> getInsights(DateTime now);
}
