import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_api_riverpod/presentation/bottom_nav_bar/state/bottom_nav_bar_state.dart';

final BottomNavBarIndexProvider = StateNotifierProvider((ref) {
  return BottomNavBarController();
});

class BottomNavBarController extends StateNotifier<BottomNavBarState> {
  BottomNavBarController()
    : super(BottomNavBarState(currentIndex: 0, isLoading: false));
  void changeIndex(int index) {
    state = state.copyWith(currentIndex: index);
  }

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }
}
