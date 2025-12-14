import '../core/model/insight.dart';

abstract class InsightsDataSource {
  List<Insight> getInsights(DateTime now);
}
