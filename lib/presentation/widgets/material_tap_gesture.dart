import 'package:flutter/material.dart';

class MaterialTapGesture extends StatelessWidget {
  const MaterialTapGesture({
    Key? key,
    this.borderRadius,
    this.onTap,
    this.onLongPress,
    this.child,
  }) : super(key: key);

  final BorderRadius? borderRadius;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      borderRadius: borderRadius,
      color: Colors.white,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: onTap,
        onLongPress: onLongPress,
        child: child,
      ),
    );
  }
}
