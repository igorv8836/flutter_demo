import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/network/dio_client.dart';
import '../core/model/quote.dart';
import '../domain/quotes_repository.dart';
import 'dto/quote_dto.dart';
import 'forismatic_remote_data_source.dart';
import 'quotes_remote_data_source.dart';

final quotesRepositoryProvider = Provider<QuotesRepository>((ref) {
  final remote = ForismaticRemoteDataSource(createDio(baseUrl: 'https://api.forismatic.com/api/1.0/'));
  return QuotesRepositoryImpl(remote);
});

class QuotesRepositoryImpl implements QuotesRepository {
  QuotesRepositoryImpl(this._remote);

  final QuotesRemoteDataSource _remote;

  @override
  Future<Quote> random({required bool english}) async {
    final dto = await _remote.random(english: english);
    return _map(dto);
  }

  @override
  Future<List<Quote>> searchSleep({required bool english}) async {
    final list = <Quote>[];
    final seen = <String>{};
    for (var i = 0; i < 12 && list.length < 6; i++) {
      final dto = await _remote.random(english: english);
      final quote = _map(dto);
      if (seen.add(quote.content)) list.add(quote);
    }
    return list;
  }

  @override
  Future<Quote> byId(String id, {required bool english}) async {
    final key = int.tryParse(id) ?? id.hashCode;
    final dto = await _remote.byKey(key, english: english);
    return _map(dto);
  }
}

Quote _map(QuoteDto dto) => Quote(
      id: dto.quoteLink ?? dto.quoteText.hashCode.toString(),
      content: dto.quoteText,
      author: dto.quoteAuthor.isEmpty ? 'Неизвестный автор' : dto.quoteAuthor,
      tags: const [],
    );
