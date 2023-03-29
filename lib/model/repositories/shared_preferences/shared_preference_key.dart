enum SharedPreferencesKey {
  /// サンプル
  sampleLocalCounter,
}

extension SharedPreferencesKeyExtension on SharedPreferencesKey {
  String get value => name;
}
