import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/model/quote.dart';
import '../data/quotes_repository_impl.dart';
import '../domain/quotes_repository.dart';
import '../../settings/presentation/settings_controller.dart';

class QuotesState {
  final bool isLoading;
  final String? error;
  final Quote? focusQuote;
  final List<Quote> sleepQuotes;

  const QuotesState({
    this.isLoading = false,
    this.error,
    this.focusQuote,
    this.sleepQuotes = const [],
  });

  QuotesState copyWith({
    bool? isLoading,
    String? error,
    Quote? focusQuote,
    List<Quote>? sleepQuotes,
  }) {
    return QuotesState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      focusQuote: focusQuote ?? this.focusQuote,
      sleepQuotes: sleepQuotes ?? this.sleepQuotes,
    );
  }
}

final quotesControllerProvider = StateNotifierProvider<QuotesController, QuotesState>((ref) {
  final repo = ref.watch(quotesRepositoryProvider);
  final settings = ref.watch(settingsControllerProvider);
  final controller = QuotesController(repo);
  controller.refresh(useEnglish: settings.useEnglishQuotes);
  return controller;
});

class QuotesController extends StateNotifier<QuotesState> {
  QuotesController(this._repository) : super(const QuotesState());

  final QuotesRepository _repository;

  Future<void> refresh({required bool useEnglish}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final focus = await _repository.random(english: useEnglish);
      final list = await _repository.searchSleep(english: useEnglish);
      state = state.copyWith(isLoading: false, focusQuote: focus, sleepQuotes: list);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Не удалось загрузить цитаты');
    }
  }

  Future<Quote?> loadById(String id, {required bool useEnglish}) async {
    final local = state.sleepQuotes.firstWhere((q) => q.id == id, orElse: () => const Quote(id: '', content: '', author: ''));
    if (local.id.isNotEmpty) return local;
    try {
      return await _repository.byId(id, english: useEnglish);
    } catch (_) {
      return null;
    }
  }
}
