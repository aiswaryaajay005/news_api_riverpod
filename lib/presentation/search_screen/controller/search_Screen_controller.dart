import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_api_riverpod/presentation/search_screen/state/search_screen_state.dart';
import 'package:news_api_riverpod/repository/api/news_res_model.dart';

final searchQueryControllerProvider =
    Provider.autoDispose<TextEditingController>(
      (ref) => TextEditingController(),
    );

final searchScreenProvider =
    StateNotifierProvider<SearchScreenController, SearchScreenState>(
      (ref) => SearchScreenController(),
    );

class SearchScreenController extends StateNotifier<SearchScreenState> {
  SearchScreenController()
    : super(
        SearchScreenState(isLoading: false, searchQuery: '', searchResults: []),
      );

  Future<void> fetchSearchedNews({required String searchQuery}) async {
    state = state.copyWith(isLoading: true, searchQuery: searchQuery);

    final response = await SearchScreenState.fetchSearchedNews(
      searchQuery: searchQuery,
    );
    if (response != null) {
      state = state.copyWith(
        isLoading: false,
        searchResults: response.articles ?? [],
      );
    } else {
      state = state.copyWith(isLoading: false, searchResults: []);
    }
  }
}
