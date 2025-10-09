import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'analytics_event.dart';

part 'analytics_logger.g.dart';

@Riverpod(keepAlive: true)
AnalyticsLogger analyticsLogger(Ref ref) =>
    AnalyticsLogger(FirebaseAnalytics.instance);

class AnalyticsLogger {
  AnalyticsLogger(this._analytics);

  final FirebaseAnalytics _analytics;

  Future<void> onScreen({
    required String screenName,
    String? screenClass,
  }) async {
    await _analytics.logScreenView(
      screenClass: screenClass ?? screenName,
      screenName: screenName,
    );
  }

  Future<void> onEvent(
    AnalyticsEvent event, {
    Map<String, Object>? params,
  }) async {
    await _analytics.logEvent(name: event.value, parameters: params);
  }
}
