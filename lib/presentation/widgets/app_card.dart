import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    required this.child,
    this.elevation = 0,
    this.borderRadius,
    this.color,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final double elevation;
  final BorderRadius? borderRadius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      borderRadius: borderRadius,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: color,
        ),
        child: child,
      ),
    );
  }
}
