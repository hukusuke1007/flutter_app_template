import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/provider.dart';
import '../res/theme.dart';
import 'main/main_page.dart';

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const locale = Locale('ja', 'JP');
    return MaterialApp(
        title: 'アプリ名', // TODO(shohei): アプリ名を設定
        theme: getAppTheme(),
        darkTheme: getAppThemeDark(),
        locale: locale,
        navigatorKey: ref.watch(navigatorKeyProvider),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          locale,
        ],
        home: const MainPage());
  }
}
