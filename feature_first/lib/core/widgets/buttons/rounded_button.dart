import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    this.height,
    this.width,
    required this.child,
    this.color,
    this.disableColor,
    this.elevation,
    this.side = BorderSide.none,
    this.isLoading = false,
    this.onTap,
    this.statesController,
    super.key,
  });

  final double? height;
  final double? width;
  final Widget child;
  final Color? color;
  final Color? disableColor;
  final double? elevation;
  final BorderSide side;
  final bool isLoading;
  final VoidCallback? onTap;
  final MaterialStatesController? statesController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: color,
          shape: const StadiumBorder().copyWith(side: side),
          disabledBackgroundColor: disableColor ?? Colors.grey,
          elevation: elevation,
        ),
        onPressed: onTap,
        statesController: statesController,
        child: isLoading ? const CupertinoActivityIndicator() : child,
      ),
    );
  }
}
