import 'package:flutter/material.dart';

class RippleTapGesture extends StatelessWidget {
  const RippleTapGesture({
    Key? key,
    this.type = MaterialType.transparency,
    this.color = Colors.white,
    this.borderRadius,
    this.onTap,
    this.onLongPress,
    this.child,
  }) : super(key: key);

  final MaterialType type;
  final Color color;
  final BorderRadius? borderRadius;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: type,
      borderRadius: borderRadius,
      color: color,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onTap,
        onLongPress: onLongPress,
        child: child,
      ),
    );
  }
}
