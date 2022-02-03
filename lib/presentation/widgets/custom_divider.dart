import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({this.height = 0.5, this.color, Key? key})
      : super(key: key);

  final double height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: ColoredBox(
        color: color ?? Colors.grey[400]!,
      ),
    );
  }
}
