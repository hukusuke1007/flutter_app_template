import 'package:flutter/material.dart';

class RoundedCard extends StatelessWidget {
  const RoundedCard({
    required this.child,
    this.color,
    this.elevation,
    super.key,
  });

  final Widget child;
  final Color? color;
  final double? elevation;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      margin: EdgeInsets.zero,
      color: color,
      shape: const StadiumBorder(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        child: child,
      ),
    );
  }
}
