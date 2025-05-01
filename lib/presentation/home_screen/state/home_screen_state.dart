import 'package:news_api_riverpod/repository/api/news_res_model.dart';
import 'package:news_api_riverpod/repository/api_helper/api_helper.dart';
import 'package:news_api_riverpod/repository/app_config/app_config.dart';

class HomeScreenState {
  final int? selectedIndex;
  List<Article> artList = [];
  // bool isLoading = true;
  final List<String> categories;
  Future<NewsResModel?> fetchNews({required String category}) async {
    final response = await ApiHelper.getData(
      endpoint: "?q=$category&apiKey=${AppConfig.apiKey}",
    );
    if (response != null) {
      NewsResModel resModel = newsResModelFromJson(response);
      return resModel;
    } else {
      return null;
    }
  }

  HomeScreenState({
    //required this.isLoading,
    required this.artList,
    required this.selectedIndex,
    this.categories = const [
      'Technology',
      'Sports',
      'Health',
      'Business',
      'Entertainment',
      'General',
      'Editorials',
      'World',
      'Politics',
      'Science',
      'Lifestyle',
      'Travel',
    ],
  });
  copyWith({bool? isLoading, List<Article>? artList}) {
    return HomeScreenState(
      artList: artList ?? this.artList,
      selectedIndex: null,
    );
  }
}
