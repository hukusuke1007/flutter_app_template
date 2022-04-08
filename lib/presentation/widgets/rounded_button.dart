import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RoundedButton extends ConsumerWidget {
  const RoundedButton({
    this.height,
    this.width,
    required this.child,
    this.color,
    this.elevation = 0,
    this.side = BorderSide.none,
    this.isLoading = false,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  final double? height;
  final double? width;
  final Widget child;
  final Color? color;
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
          primary: color,
          shape: const StadiumBorder().copyWith(side: side),
          onPrimary: Colors.grey,
          elevation: elevation,
        ),
        onPressed: onPressed,
        child: isLoading ? const CupertinoActivityIndicator() : child,
      ),
    );
  }
}
