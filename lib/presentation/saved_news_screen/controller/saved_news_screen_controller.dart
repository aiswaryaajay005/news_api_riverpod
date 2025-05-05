import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_api_riverpod/presentation/saved_news_screen/state/saved_news_screen_state.dart';

import 'package:news_api_riverpod/repository/sqflite_helper/sqflite_helper.dart';

class SavedNewsScreenController extends StateNotifier<SavedNewsScreenState> {
  SavedNewsScreenController() : super(SavedNewsScreenState()) {
    _loadSavedNews(); // Load saved news when the controller is initialized
  }

  Future<void> _loadSavedNews() async {
    final news = await SqfliteHelper.getAllData();
    state = state.copyWith(savedNews: news.cast<Map<String, dynamic>>());
  }

  Future<void> deleteNews(int id) async {
    await SqfliteHelper.deleteNews(id);
    await _loadSavedNews();
  }

  Future<void> addNews(String? title, String? source, String? imageUrl) async {
    await SqfliteHelper.addNewData(
      title: title,
      source: source,
      imageUrl: imageUrl,
    );
    await _loadSavedNews();
  }

  Future<bool> isArticleSaved(String title) async {
    return await SqfliteHelper.isNewsSaved(title);
  }
}

final savedNewsScreenProvider =
    StateNotifierProvider<SavedNewsScreenController, SavedNewsScreenState>(
      (ref) => SavedNewsScreenController(),
    );
