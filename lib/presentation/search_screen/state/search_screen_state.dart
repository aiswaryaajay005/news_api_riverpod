import 'package:news_api_riverpod/repository/api/news_res_model.dart';
import 'package:news_api_riverpod/repository/api_helper/api_helper.dart';
import 'package:news_api_riverpod/repository/app_config/app_config.dart';

class SearchScreenState {
  final String searchQuery;
  final bool isLoading;
  final List<Article> searchResults;

  SearchScreenState({
    required this.searchQuery,
    required this.isLoading,
    required this.searchResults,
  });

  static Future<NewsResModel?> fetchSearchedNews({
    required String searchQuery,
  }) async {
    final response = await ApiHelper.getData(
      endpoint: "?q=$searchQuery&apiKey=${AppConfig.apiKey}",
    );
    if (response != null) {
      return newsResModelFromJson(response);
    } else {
      return null;
    }
  }

  SearchScreenState copyWith({
    String? searchQuery,
    bool? isLoading,
    List<Article>? searchResults,
  }) {
    return SearchScreenState(
      searchQuery: searchQuery ?? this.searchQuery,
      isLoading: isLoading ?? this.isLoading,
      searchResults: searchResults ?? this.searchResults,
    );
  }
}
