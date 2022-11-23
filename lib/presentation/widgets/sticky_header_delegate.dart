import 'package:flutter/material.dart';

class StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  const StickyHeaderDelegate({
    required this.child,
    required this.height,
    this.color,
  });

  final Widget child;
  final double height;
  final Color? color;

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    if (color != null) {
      return ColoredBox(color: color!, child: child);
    }
    return child;
  }

  @override
  bool shouldRebuild(StickyHeaderDelegate oldDelegate) {
    return child != oldDelegate.child;
  }
}
