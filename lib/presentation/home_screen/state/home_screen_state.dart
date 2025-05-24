import 'package:news_api_riverpod/repository/api/news_res_model.dart';
import 'package:news_api_riverpod/repository/api_helper/api_helper.dart';
import 'package:news_api_riverpod/repository/app_config/app_config.dart';

class HomeScreenState {
  final int? selectedIndex;
  List<Article> artList = [];
  final List<String> savedTitles;
  bool isLoading = true;
  final DateTime todayDate;
  Future<NewsResModel?> fetchNews({required String category}) async {
    final response = await ApiHelper.getData(
      endpoint: "everything?q=$category&apiKey=${AppConfig.apiKey}",
    );
    if (response != null) {
      NewsResModel resModel = newsResModelFromJson(response);
      return resModel;
    } else {
      return null;
    }
  }

  HomeScreenState({
    required this.artList,
    required this.selectedIndex,
    required this.isLoading,
    this.savedTitles = const [],
    required this.todayDate,
  });
  copyWith({
    bool? isLoading,
    List<Article>? artList,
    List<String>? savedTitles,
    DateTime? todayDate,
  }) {
    return HomeScreenState(
      artList: artList ?? this.artList,
      selectedIndex: null,
      isLoading: isLoading ?? this.isLoading,
      savedTitles: savedTitles ?? this.savedTitles,
      todayDate: todayDate ?? this.todayDate,
    );
  }
}
