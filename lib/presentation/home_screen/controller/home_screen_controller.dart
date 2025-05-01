import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_api_riverpod/presentation/home_screen/state/home_screen_state.dart';
import 'package:news_api_riverpod/repository/api/news_res_model.dart';

class HomeScreenNotifier extends StateNotifier<HomeScreenState> {
  HomeScreenNotifier() : super(HomeScreenState(selectedIndex: 0, artList: []));

  Future<void> fetchNews({required String category}) async {
    try {
      final response = await HomeScreenState(
        selectedIndex: 1,

        artList: [],
      ).fetchNews(category: category);
      if (response != null) {
        print("Data fetched successfully");
        NewsResModel res = response;
        state.artList = res.articles!;
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

final homeProvider = StateNotifierProvider((ref) {
  return HomeScreenNotifier();
});
