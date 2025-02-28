import 'package:flutter/material.dart';

class ButtonStyles {
  ButtonStyles._();

  static ButtonStyle normal({
    double elevation = 2,
    Size minimumSize = const Size(80, 40),
  }) => FilledButton.styleFrom(elevation: elevation, minimumSize: minimumSize);

  /// 画面幅いっぱいのボタンスタイル
  static ButtonStyle fullWidth({double elevation = 2, double height = 48}) =>
      FilledButton.styleFrom(
        elevation: elevation,
        minimumSize: Size(double.infinity, height),
      );

  /// 角丸のボタンスタイル
  static ButtonStyle rounded({
    double elevation = 2,
    Size minimumSize = const Size(80, 40),
    double radius = 24,
  }) => FilledButton.styleFrom(
    elevation: elevation,
    minimumSize: minimumSize,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
  );

  /// テキストボタンスタイル
  static ButtonStyle textButton({
    Color foregroundColor = Colors.blueAccent,
    Size minimumSize = const Size(80, 40),
  }) => TextButton.styleFrom(
    foregroundColor: foregroundColor,
    minimumSize: minimumSize,
  );
}
