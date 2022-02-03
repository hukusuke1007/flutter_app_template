import 'package:flutter/material.dart';

class LeadingBackButton extends StatelessWidget {
  const LeadingBackButton({
    this.color,
    Key? key,
  }) : super(key: key);

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        color: color ?? Colors.white,
      ),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}

class LeadingModalBackButton extends StatelessWidget {
  const LeadingModalBackButton({
    this.color,
    Key? key,
  }) : super(key: key);

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.close,
        color: color ?? Colors.white,
      ),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}
