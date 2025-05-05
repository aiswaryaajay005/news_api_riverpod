import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_api_riverpod/presentation/home_screen/state/home_screen_state.dart';
import 'package:news_api_riverpod/repository/api/news_res_model.dart';
import 'package:news_api_riverpod/repository/sqflite_helper/sqflite_helper.dart';

final homeProvider = StateNotifierProvider((ref) {
  return HomeScreenNotifier();
});

class HomeScreenNotifier extends StateNotifier<HomeScreenState> {
  HomeScreenNotifier()
    : super(
        HomeScreenState(
          selectedIndex: 0,
          artList: [],
          isLoading: true,
          savedTitles: [],
          todayDate: DateTime.now(),
        ),
      );

  Future<void> fetchNews({required String category}) async {
    try {
      state = state.copyWith(isLoading: true);
      final response = await state.fetchNews(category: category);

      if (response != null) {
        final saved = await SqfliteHelper.getAllData();
        final savedTitles =
            saved.map((e) => e['title']?.toString() ?? '').toList();

        NewsResModel res = response;
        state = state.copyWith(
          isLoading: false,
          artList: res.articles!,
          savedTitles: savedTitles,
          todayDate: DateTime.now(),
        );
      } else {
        print("No data found");
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      print("Error fetching news: $e");
      state = state.copyWith(isLoading: false);
    }
  }
}
