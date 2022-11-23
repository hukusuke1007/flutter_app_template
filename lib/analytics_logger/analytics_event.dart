import 'package:recase/recase.dart';

enum AnalyticsEvent {
  signOut,
  ;

  String get valueWithSnakeCase => ReCase(name).snakeCase;
}

extension AnalyticsEventParams on AnalyticsEvent {
  static Map<String, dynamic> signOut({
    required String? userId,
  }) =>
      <String, dynamic>{
        'user_id': userId,
      };
}
