import '../core/model/quote.dart';

abstract class QuotesRepository {
  Future<Quote> random({required bool english});
  Future<List<Quote>> searchSleep({required bool english});
  Future<Quote> byId(String id, {required bool english});
}
