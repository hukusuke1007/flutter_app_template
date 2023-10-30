import 'package:flutter/material.dart';

class ColorCircle extends StatelessWidget {
  const ColorCircle({
    required this.size,
    required this.color,
    this.child,
    super.key,
  });

  final double size;
  final Color color;
  final Widget? child;

  static Widget unreadIcon() {
    return const ColorCircle(
      size: 8,
      color: Colors.redAccent,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: child != null ? Center(child: child) : null,
    );
  }
}

class ColorCircleIcon extends StatelessWidget {
  const ColorCircleIcon({
    required this.child,
    this.size = 24,
    this.color,
    this.onTap,
    super.key,
  });

  final Widget child;
  final double size;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ColorCircle(
        size: size,
        color: color ?? Colors.black.withOpacity(0.5),
        child: child,
      ),
    );
  }
}
