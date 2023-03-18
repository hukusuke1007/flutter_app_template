import 'package:flutter/material.dart';
import 'package:flutter_app_template/utils/logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TransitionObserver extends NavigatorObserver {
  TransitionObserver(this._ref);
  final Ref _ref;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _onTransition(route, previousRoute, 'push');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    _onTransition(route, previousRoute, 'pop');
  }

  void _onTransition(
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
    String transitionType,
  ) {
    logger.info(
      'Transition: $transitionType, ${route.settings.name}',
    );
  }
}
