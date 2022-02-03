enum SharedPreferencesKey {
  /// アプリレビュー
  isReviewedAppStore,
  showingReviewAt,

  /// サンプル
  sampleLocalCounter,
}

extension SharedPreferencesKeyExtension on SharedPreferencesKey {
  String get value => name;
}
