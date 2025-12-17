import 'package:dio/dio.dart';

import 'dto/quote_dto.dart';
import 'quotes_remote_data_source.dart';

class ForismaticRemoteDataSource implements QuotesRemoteDataSource {
  ForismaticRemoteDataSource(this._dio);

  final Dio _dio;

  @override
  Future<QuoteDto> random({required bool english}) => _fetch(lang: english ? 'en' : 'ru');

  @override
  Future<QuoteDto> byKey(int key, {required bool english}) => _fetch(lang: english ? 'en' : 'ru', key: key);

  Future<QuoteDto> _fetch({required String lang, int? key}) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/',
      queryParameters: {
        'method': 'getQuote',
        'format': 'json',
        'lang': lang,
        if (key != null) 'key': key,
      },
    );
    final data = response.data;
    if (data == null) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        message: 'Пустой ответ от Forismatic',
        type: DioExceptionType.badResponse,
      );
    }
    return QuoteDto.fromJson(data);
  }
}
