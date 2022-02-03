enum SharedPreferencesKey {
  isReviewedAppStore,
  showingReviewAt,

  /// サンプルカウンター
  sampleCounter,
}

extension SharedPreferencesKeyExtension on SharedPreferencesKey {
  String get value => name;
}
