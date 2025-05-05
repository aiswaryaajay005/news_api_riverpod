import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_api_riverpod/presentation/breaking_news_screen/state/breaking_news_screen_state.dart';

final BreakingNewsProvider = StateNotifierProvider((ref) {
  return BreakingNewsScreenController();
});

class BreakingNewsScreenController
    extends StateNotifier<BreakingNewsScreenState> {
  BreakingNewsScreenController()
    : super(BreakingNewsScreenState(artList: [], isLoading: false));

  Future<void> fetchBreakingNews({required String category}) async {
    try {
      state = state.copyWith(isLoading: true);
      final response = await BreakingNewsScreenState(
        isLoading: true,
        artList: [],
      ).fetchBreakingNews(category: category);
      if (response != null) {
        print("Data fetched successfully");
        state.artList = response.articles!;
        state = state.copyWith(isLoading: false);
      } else {
        print("No data found");
      }
    } catch (e) {
      print("Error fetching employees: $e");
    }
    state = state.copyWith(isLoading: false);
  }
}
