enum AnalyticsEvent {
  signOut('sign_out'),
  ;

  const AnalyticsEvent(this.value);
  final String value;
}

extension AnalyticsEventParams on AnalyticsEvent {
  static Map<String, Object> signOut({
    required String userId,
  }) =>
      <String, Object>{
        'user_id': userId,
      };
}
