import 'dto/quote_dto.dart';

abstract class QuotesRemoteDataSource {
  Future<QuoteDto> random({required bool english});
  Future<QuoteDto> byKey(int key, {required bool english});
}
