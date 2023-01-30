import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ModalTransitionPage<T> extends CustomTransitionPage<T> {
  const ModalTransitionPage({
    required super.child,
    super.name,
    super.arguments,
    super.restorationId,
    super.key,
  }) : super(
          transitionsBuilder: _transitionsBuilder,
          transitionDuration: const Duration(milliseconds: 300),
          fullscreenDialog: true,
        );

  static Widget _transitionsBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SlideTransition(
      position: animation
          .drive(
            CurveTween(
              curve: const Interval(0, 1, curve: Curves.fastOutSlowIn),
            ),
          )
          .drive(
            Tween(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ),
          ),
      child: child,
    );
  }
}
