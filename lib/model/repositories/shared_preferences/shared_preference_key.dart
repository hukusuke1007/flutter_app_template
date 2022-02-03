enum SharedPreferencesKey {
  isReviewedAppStore,
  showingReviewAt,
}

extension SharedPreferencesKeyExtension on SharedPreferencesKey {
  String get value => name;
}
