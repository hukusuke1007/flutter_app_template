import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './gen/colors.gen.dart';

/// Migrating a Flutter app to Material 3
/// https://blog.codemagic.io/migrating-a-flutter-app-to-material-3/

ThemeData getAppTheme() {
  const primaryColor = ColorName.primary;

  final base = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      surfaceTint: Colors.white,
    ),
  );

  return base.copyWith(
    primaryColor: primaryColor,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: primaryColor,
      ), //ButtonStyleでも可
    ),
    appBarTheme: base.appBarTheme.copyWith(
      iconTheme: base.iconTheme.copyWith(color: Colors.white),
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
    ),
    floatingActionButtonTheme: base.floatingActionButtonTheme.copyWith(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: base.bottomNavigationBarTheme.copyWith(
      backgroundColor: Colors.white,
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.black.withOpacity(0.4),
    ),
    cupertinoOverrideTheme: NoDefaultCupertinoThemeData(
      brightness: Brightness.light,
      textTheme: CupertinoTextThemeData(
        dateTimePickerTextStyle: base.textTheme.bodyMedium!.copyWith(
          fontSize: 15,
        ),
      ),
    ),

    /// AndroidもCupertinoPageTransitionsBuilderに設定する
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
      },
    ),
  );
}

ThemeData getAppThemeDark() {
  const primaryColor = ColorName.primary;

  final base = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.dark,
      surfaceTint: Colors.white,
    ),
  );
  return base.copyWith(
    primaryColor: primaryColor,

    colorScheme: base.colorScheme.copyWith(
      primary: primaryColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: primaryColor,
      ), //ButtonStyleでも可
    ),
    appBarTheme: base.appBarTheme.copyWith(
      iconTheme: base.iconTheme.copyWith(color: Colors.white),
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
    floatingActionButtonTheme: base.floatingActionButtonTheme.copyWith(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: base.bottomNavigationBarTheme.copyWith(
      selectedItemColor: primaryColor,
    ),
    cupertinoOverrideTheme: NoDefaultCupertinoThemeData(
      brightness: Brightness.dark,
      textTheme: CupertinoTextThemeData(
        dateTimePickerTextStyle: base.textTheme.bodyMedium!.copyWith(
          fontSize: 15,
        ),
      ),
    ),

    /// AndroidもCupertinoPageTransitionsBuilderに設定する
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
      },
    ),
  );
}
