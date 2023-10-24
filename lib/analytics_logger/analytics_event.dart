enum AnalyticsEvent {
  signOut('sign_out'),
  ;

  const AnalyticsEvent(this.value);
  final String value;
}

extension AnalyticsEventParams on AnalyticsEvent {
  static Map<String, dynamic> signOut({
    required String? userId,
  }) =>
      <String, dynamic>{
        'user_id': userId,
      };
}
