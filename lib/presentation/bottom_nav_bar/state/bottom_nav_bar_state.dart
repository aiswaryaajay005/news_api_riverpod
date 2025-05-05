class BottomNavBarState {
  int currentIndex = 0;
  bool isLoading = false;

  BottomNavBarState({this.currentIndex = 0, this.isLoading = false});

  BottomNavBarState copyWith({int? currentIndex, bool? isLoading}) {
    return BottomNavBarState(
      currentIndex: currentIndex ?? this.currentIndex,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
