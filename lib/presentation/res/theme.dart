import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../gen/colors.gen.dart';
import 'typography.dart';

/// https://flutter.dev/docs/release/breaking-changes/theme-data-accent-properties#migration-guide
ThemeData getAppTheme() {
  final base = ThemeData(
    brightness: Brightness.light,
    fontFamily: kFontFamily,
    typography: kTypography,
    primaryColor: ColorName.primary,
  );
  return base.copyWith(
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: ColorName.primary,
      textTheme: ButtonTextTheme.normal,
    ),
    appBarTheme: base.appBarTheme.copyWith(
      iconTheme: base.iconTheme.copyWith(color: Colors.grey),
    ),
    floatingActionButtonTheme: base.floatingActionButtonTheme.copyWith(
      backgroundColor: ColorName.primary,
      foregroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: base.bottomNavigationBarTheme.copyWith(
      backgroundColor: Colors.white,
      selectedItemColor: ColorName.primary,
      unselectedItemColor: Colors.black.withOpacity(0.4),
    ),
    cupertinoOverrideTheme: NoDefaultCupertinoThemeData(
      brightness: Brightness.light,
      textTheme: CupertinoTextThemeData(
        dateTimePickerTextStyle: textTheme(base.textTheme).bodyText2!.copyWith(
              fontSize: 15,
            ),
      ),
    ),
    textTheme: textTheme(base.textTheme),
  );
}

ThemeData getAppThemeDark() {
  final base = ThemeData.from(colorScheme: const ColorScheme.dark());
  return base.copyWith(
    typography: kTypography,
    primaryColor: ColorName.primary,
    colorScheme: base.colorScheme.copyWith(
      primary: ColorName.primary,
    ),
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: ColorName.primary,
      textTheme: ButtonTextTheme.normal,
    ),
    appBarTheme: base.appBarTheme.copyWith(
      iconTheme: base.iconTheme.copyWith(color: Colors.grey),
    ),
    floatingActionButtonTheme: base.floatingActionButtonTheme.copyWith(
      backgroundColor: ColorName.primary,
      foregroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: base.bottomNavigationBarTheme.copyWith(
      selectedItemColor: ColorName.primary,
    ),
    cupertinoOverrideTheme: NoDefaultCupertinoThemeData(
      brightness: Brightness.dark,
      textTheme: CupertinoTextThemeData(
        dateTimePickerTextStyle: textTheme(base.textTheme).bodyText2!.copyWith(
              fontSize: 15,
            ),
      ),
    ),
    textTheme: textTheme(base.textTheme),
  );
}
