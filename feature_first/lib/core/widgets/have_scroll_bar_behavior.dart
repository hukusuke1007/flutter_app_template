import 'package:flutter/material.dart';

class HaveScrollBarBehavior extends MaterialScrollBehavior {
  const HaveScrollBarBehavior();

  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    switch (axisDirectionToAxis(details.direction)) {
      case Axis.horizontal:
        return child;
      case Axis.vertical:
        return Scrollbar(
          controller: details.controller,
          child: child,
        );
    }
  }
}
