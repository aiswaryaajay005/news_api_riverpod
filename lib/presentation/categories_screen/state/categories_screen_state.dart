class CategoriesScreenState {
  CategoriesScreenState({
    this.isLoading = false,
    this.categories = const [],
    this.errorMessage,
  });

  final bool isLoading;
  final List<String> categories;
  final String? errorMessage;

  CategoriesScreenState copyWith({
    bool? isLoading,
    List<String>? categories,
    String? errorMessage,
  }) {
    return CategoriesScreenState(
      isLoading: isLoading ?? this.isLoading,
      categories: categories ?? this.categories,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
