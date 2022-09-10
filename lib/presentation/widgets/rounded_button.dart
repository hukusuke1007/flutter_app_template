import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    this.height,
    this.width,
    required this.child,
    this.color,
    this.elevation = 0,
    this.side = BorderSide.none,
    this.isLoading = false,
    this.onTap,
    super.key,
  });

  final double? height;
  final double? width;
  final Widget child;
  final Color? color;
  final double elevation;
  final BorderSide side;
  final bool isLoading;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: color,
          shape: const StadiumBorder().copyWith(side: side),
          disabledBackgroundColor: Colors.grey,
          elevation: elevation,
        ),
        onPressed: onTap,
        child: isLoading ? const CupertinoActivityIndicator() : child,
      ),
    );
  }
}
