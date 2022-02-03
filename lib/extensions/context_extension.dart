import 'package:flutter/material.dart';

import '../presentation/res/colors.dart';

extension ContextExtension on BuildContext {
  bool get isDark => MediaQuery.of(this).platformBrightness == Brightness.dark;
  bool get isSafeArea => MediaQuery.of(this).viewPadding.bottom >= 34.0;
  double get deviceWidth => MediaQuery.of(this).size.width;
  double get deviceHeight => MediaQuery.of(this).size.height;
  bool get isAndroid => Theme.of(this).platform == TargetPlatform.android;
  bool get isIOS => Theme.of(this).platform == TargetPlatform.iOS;
  TextStyle get titleStyle => Theme.of(this).textTheme.headline5!;
  TextStyle get subtitleStyle => Theme.of(this).textTheme.subtitle1!;
  TextStyle get bodyStyle => Theme.of(this).textTheme.bodyText2!;
  TextStyle get smallStyle => Theme.of(this).textTheme.caption!.copyWith();
  TextStyle get verySmallStyle =>
      Theme.of(this).textTheme.caption!.copyWith(fontSize: 10);
  Color? get commentBgColor =>
      isDark ? ThemeData.dark().backgroundColor : Colors.grey[300];
  bool get isIphoneMiniSize =>
      deviceWidth == 320 && deviceHeight == 568; // iPhone SE 1st
  double get appBarHeight => MediaQuery.of(this).padding.top + kToolbarHeight;

  Color get scaffoldBackgroundColor => isDark
      ? const ColorScheme.dark().background
      : ThemeData.light().scaffoldBackgroundColor;

  Color get cardColor =>
      isDark ? ThemeData.dark().cardColor : ThemeData.light().cardColor;

  void hideKeyboard() => FocusScope.of(this).unfocus();
  void showSnackBar(String text, {Color backgroundColor = kPrimaryColor}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        content: Text(
          text,
          style: bodyStyle.copyWith(color: Colors.white),
        ),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
            label: '閉じる', textColor: Colors.white, onPressed: () {}),
      ),
    );
  }
}
