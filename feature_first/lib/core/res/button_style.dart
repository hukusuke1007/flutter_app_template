import 'package:flutter/material.dart';

const kButtonMinimumHeight = 40.0;

class ButtonStyles {
  ButtonStyles._();

  static ButtonStyle normal({
    double elevation = 2,
  }) =>
      FilledButton.styleFrom(
        elevation: elevation,
        minimumSize: const Size(80, 40),
      );
}
