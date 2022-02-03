import 'package:flutter/material.dart';

class LabelCard extends StatelessWidget {
  const LabelCard({
    required this.child,
    this.color,
    this.elevation = 0,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final Color? color;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      color: color,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: child,
      ),
    );
  }
}
