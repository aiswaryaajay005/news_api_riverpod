import 'package:news_api_riverpod/repository/api/news_res_model.dart';
import 'package:news_api_riverpod/repository/api_helper/api_helper.dart';
import 'package:news_api_riverpod/repository/app_config/app_config.dart';

class BreakingNewsScreenState {
  List<Article> artList = [];
  bool isLoading = true;
  Future<NewsResModel?> fetchBreakingNews({required String category}) async {
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

  BreakingNewsScreenState({required this.artList, required this.isLoading});
  copyWith({bool? isLoading, List<Article>? artList}) {
    return BreakingNewsScreenState(
      artList: artList ?? this.artList,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
