import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RoundedButton extends ConsumerWidget {
  const RoundedButton({
    required this.child,
    this.bgColor,
    this.height = 40,
    this.width = 140,
    this.elevation = 0,
    this.side = BorderSide.none,
    this.isLoading = false,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  final Widget child;
  final Color? bgColor;
  final double height;
  final double width;
  final double elevation;
  final BorderSide side;
  final bool isLoading;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(height / 2),
            side: side,
          ),
          onPrimary: Colors.grey,
          elevation: elevation,
        ),
        onPressed: onPressed,
        child: isLoading ? const CupertinoActivityIndicator() : child,
      ),
    );
  }
}
