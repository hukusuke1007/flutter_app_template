import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../utils/logger.dart';
import 'model/repositories/package_info/package_info_repository.dart';
import 'model/repositories/shared_preferences/shared_preference_repository.dart';
import 'model/use_cases/images/image_compress.dart';
import 'presentation/pages/app.dart';
import 'utils/flavor.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  late final PackageInfo packageInfo;
  late final SharedPreferences sharedPreferences;
  late final Directory tempDirectory;
  Logger.configure();

  await (
    /// Firebase
    Firebase.initializeApp(),

    /// 縦固定
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]),

    Future(() async {
      packageInfo = await PackageInfo.fromPlatform();
    }),
    Future(() async {
      sharedPreferences = await SharedPreferences.getInstance();
    }),
    Future(() async {
      tz.initializeTimeZones();
      final currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(currentTimeZone));
    }),
    Future(() async {
      tempDirectory = await getTemporaryDirectory();
    }),
  ).wait;

  logger.info(Flavor.environment);

  /// Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesRepositoryProvider
            .overrideWithValue(SharedPreferencesRepository(sharedPreferences)),
        packageInfoRepositoryProvider
            .overrideWithValue(PackageInfoRepository(packageInfo)),
        imageCompressProvider.overrideWithValue(ImageCompress(tempDirectory)),
      ],
      child: const App(),
    ),
  );
}
