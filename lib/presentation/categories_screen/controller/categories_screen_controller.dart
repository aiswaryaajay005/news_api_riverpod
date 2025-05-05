import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_api_riverpod/presentation/categories_screen/state/categories_screen_state.dart';

final CategoriesScreenProvider = StateNotifierProvider((ref) {
  return CategoriesScreenController();
});

class CategoriesScreenController extends StateNotifier<CategoriesScreenState> {
  CategoriesScreenController()
    : super(
        CategoriesScreenState(
          categories: [
            "Technology",
            "Sports",
            "Health",
            "Business",
            "Entertainment",
            " General",
            "Editorials",
            "World",
            "Politics",
            "Science",
            "Lifestyle",
            "Travel",
            "Food",
            "Fashion",
          ],
          isLoading: true,
        ),
      );
}
