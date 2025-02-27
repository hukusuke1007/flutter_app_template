import 'package:flutter/material.dart';

class NoAnimationRoute {
  NoAnimationRoute._();
  static Future<T?> show<T>(
    BuildContext context,
    Widget page, {
    bool rootNavigator = true,
    bool fullscreenDialog = false,
  }) {
    return Navigator.of(context, rootNavigator: rootNavigator).push<T>(
      PageRouteBuilder<T>(
        pageBuilder: (_, _, _) => page,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        fullscreenDialog: fullscreenDialog,
      ),
    );
  }
}
