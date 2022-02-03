import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';
import 'typography.dart';

/// https://flutter.dev/docs/release/breaking-changes/theme-data-accent-properties#migration-guide
ThemeData getAppTheme({
  Color? appBarColor,
  Color? selectedItemColor,
  Color? floatingActionButtonColor,
}) {
  final base = ThemeData(
    brightness: Brightness.light,
    fontFamily: kFontFamily,
    typography: kTypography,
    primaryColor: kPrimaryColor,
  );
  return base.copyWith(
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: kPrimaryColor,
      textTheme: ButtonTextTheme.normal,
    ),
    appBarTheme: base.appBarTheme.copyWith(
      backgroundColor: appBarColor,
      iconTheme: base.iconTheme.copyWith(color: Colors.grey),
    ),
    floatingActionButtonTheme: base.floatingActionButtonTheme.copyWith(
      backgroundColor: floatingActionButtonColor ?? kPrimaryColor,
      foregroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: base.bottomNavigationBarTheme.copyWith(
      backgroundColor: Colors.white,
      selectedItemColor: selectedItemColor ?? kPrimaryColor,
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
    scaffoldBackgroundColor: Colors.white,
    textTheme: textTheme(base.textTheme),
  );
}

ThemeData getAppThemeDark({
  Color? appBarColor,
  Color? selectedItemColor,
  Color? floatingActionButtonColor,
}) {
  final base = ThemeData.from(colorScheme: const ColorScheme.dark());
  return base.copyWith(
    typography: kTypography,
    primaryColor: kPrimaryColor,
    colorScheme: base.colorScheme.copyWith(secondary: kPrimaryColor),
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: kPrimaryColor,
      textTheme: ButtonTextTheme.normal,
    ),
    appBarTheme: base.appBarTheme.copyWith(
      backgroundColor: appBarColor,
      iconTheme: base.iconTheme.copyWith(color: Colors.grey),
    ),
    floatingActionButtonTheme: base.floatingActionButtonTheme.copyWith(
      backgroundColor: floatingActionButtonColor ?? kPrimaryColor,
      foregroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: base.bottomNavigationBarTheme.copyWith(
      selectedItemColor: selectedItemColor ?? kPrimaryColor,
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
