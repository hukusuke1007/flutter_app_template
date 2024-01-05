import 'package:flutter/material.dart';

class ButtonStyles {
  ButtonStyles._();

  static ButtonStyle normal({
    double elevation = 2,
    Size minimumSize = const Size(80, 40),
  }) =>
      FilledButton.styleFrom(
        elevation: elevation,
        minimumSize: minimumSize,
      );
}
