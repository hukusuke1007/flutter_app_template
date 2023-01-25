import 'package:flutter/material.dart';

import '../gen/colors.gen.dart';

extension ContextExtension on BuildContext {
  bool get isDark => MediaQuery.of(this).platformBrightness == Brightness.dark;
  double get deviceWidth => MediaQuery.of(this).size.width;
  double get deviceHeight => MediaQuery.of(this).size.height;
  bool get isAndroid => Theme.of(this).platform == TargetPlatform.android;
  bool get isIOS => Theme.of(this).platform == TargetPlatform.iOS;
  TextStyle get titleStyle => Theme.of(this).textTheme.headlineSmall!;
  TextStyle get subtitleStyle => Theme.of(this).textTheme.titleMedium!;
  TextStyle get bodyStyle => Theme.of(this).textTheme.bodyMedium!;
  TextStyle get smallStyle => Theme.of(this).textTheme.bodySmall!;
  TextStyle get verySmallStyle =>
      Theme.of(this).textTheme.bodySmall!.copyWith(fontSize: 10);
  bool get isIphoneMiniSize =>
      deviceWidth == 320 && deviceHeight == 568; // iPhone SE 1st
  double get appBarHeight => MediaQuery.of(this).padding.top + kToolbarHeight;

  Color get scaffoldBackgroundColor => Theme.of(this).scaffoldBackgroundColor;

  void hideKeyboard() {
    // https://github.com/flutter/flutter/issues/54277#issuecomment-640998757
    final currentScope = FocusScope.of(this);
    if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  void showSnackBar(
    String text, {
    Color backgroundColor = ColorName.primary,
    Duration duration = const Duration(milliseconds: 1500),
    VoidCallback? onTap,
    String closeLabel = '閉じる',
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        content: Text(
          text,
          style: bodyStyle.copyWith(color: Colors.white),
        ),
        duration: duration,
        action: SnackBarAction(
          label: closeLabel,
          textColor: Colors.white,
          onPressed: () {
            if (onTap != null) {
              onTap();
            }
          },
        ),
      ),
    );
  }
}
