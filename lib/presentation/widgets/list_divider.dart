import 'package:flutter/material.dart';

class ListDivider extends StatelessWidget {
  const ListDivider({
    this.color = Colors.grey,
    this.height = 0.5,
    Key? key,
  }) : super(key: key);

  final double height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      height: height,
      width: double.infinity,
    );
  }
}
