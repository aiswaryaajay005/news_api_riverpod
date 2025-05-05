class SavedNewsScreenState {
  final List<Map<String, dynamic>> savedNews;

  SavedNewsScreenState({this.savedNews = const []});

  SavedNewsScreenState copyWith({List<Map<String, dynamic>>? savedNews}) {
    return SavedNewsScreenState(savedNews: savedNews ?? this.savedNews);
  }
}
