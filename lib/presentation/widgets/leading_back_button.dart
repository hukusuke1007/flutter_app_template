import 'package:flutter/material.dart';

class LeadingBackButton extends StatelessWidget {
  const LeadingBackButton({
    this.color = Colors.white,
    super.key,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        color: color,
      ),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}

class LeadingModalBackButton extends StatelessWidget {
  const LeadingModalBackButton({
    this.color = Colors.white,
    super.key,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.close,
        color: color,
      ),
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}
