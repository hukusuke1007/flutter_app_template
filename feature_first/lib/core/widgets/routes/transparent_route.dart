import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransparentRoute<T> extends PageRoute<T>
    with CupertinoRouteTransitionMixin<T> {
  TransparentRoute({
    required this.builder,
    required this.backgroundColor,
    required this.transitionDuration,
    required this.reverseTransitionDuration,
    this.title,
    super.settings,
    this.maintainState = true,
    super.fullscreenDialog = true,
  });

  static Future<T?> show<T>(
    BuildContext context,
    Widget page, {
    Color backgroundColor = Colors.transparent,
    Duration transitionDuration = const Duration(milliseconds: 350),
    Duration reverseTransitionDuration = const Duration(milliseconds: 350),
    bool rootNavigator = true,
  }) async {
    return Navigator.of(context, rootNavigator: rootNavigator).push<T>(
      TransparentRoute(
        builder: (_) => page,
        backgroundColor: backgroundColor,
        transitionDuration: transitionDuration,
        reverseTransitionDuration: reverseTransitionDuration,
      ),
    );
  }

  final WidgetBuilder builder;

  @override
  final String? title;

  @override
  final bool maintainState;

  @override
  final Duration transitionDuration;

  @override
  final Duration reverseTransitionDuration;

  final Color backgroundColor;

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) =>
      FadeTransition(opacity: animation, child: child);

  @override
  Color get barrierColor => backgroundColor;

  @override
  Widget buildContent(BuildContext context) => builder(context);

  @override
  String get debugLabel => '${super.debugLabel}(${settings.name})';

  @override
  bool get barrierDismissible => true;

  @override
  bool get opaque => false;
}
