import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'analytics_event.dart';

final analyticsLoggerProvider = Provider<AnalyticsLogger>((ref) {
  return AnalyticsLogger(FirebaseAnalytics.instance);
});

class AnalyticsLogger {
  AnalyticsLogger(this._analytics);

  final FirebaseAnalytics _analytics;

  Future<void> onScreen({
    required String screenName,
    String? screenClassOverride,
  }) async {
    await _analytics.setCurrentScreen(
      screenName: screenName,
      screenClassOverride: screenClassOverride ?? screenName,
    );
  }

  Future<void> onEvent(
    AnalyticsEvent event, {
    Map<String, dynamic>? params,
  }) async {
    await _analytics.logEvent(
      name: event.valueWithSnakeCase,
      parameters: params,
    );
  }
}
