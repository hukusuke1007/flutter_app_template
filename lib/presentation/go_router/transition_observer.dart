import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/logger.dart';

enum TransitionType {
  push,
  pop,
}

final transitionObserverProvider = Provider(
  TransitionObserver.new,
);

class TransitionObserver extends NavigatorObserver {
  TransitionObserver(this._ref);
  // ignore: unused_field
  final Ref _ref;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _onTransition(route, previousRoute, TransitionType.push);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    _onTransition(route, previousRoute, TransitionType.pop);
  }

  void _onTransition(
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
    TransitionType transitionType,
  ) {
    final pageName = route.settings.name;
    logger.info('pageName: $pageName, ${transitionType.name}');
  }
}
