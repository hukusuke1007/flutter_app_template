import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app.dart';
import 'model/repositories/shared_preferences/shared_preference_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  late final SharedPreferences sharedPreferences;

  await (
    /// 縦固定
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]),

    Future(() async {
      sharedPreferences = await SharedPreferences.getInstance();
    }),
  ).wait;

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesRepositoryProvider
            .overrideWithValue(SharedPreferencesRepository(sharedPreferences)),
      ],
      child: const App(),
    ),
  );
}
