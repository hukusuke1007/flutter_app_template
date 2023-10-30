import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'presentation/pages/main/main_page.dart';
import 'presentation/res/theme.dart';
import 'presentation/widgets/have_scroll_bar_behavior.dart';
import 'utils/navigator_key_provider.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'テンプレアプリ',
      navigatorKey: ref.watch(navigatorKeyProvider),

      /// スクロールバーをデフォルトで付与したい場合は設定する
      scrollBehavior: const HaveScrollBarBehavior(),

      theme: getAppTheme(),
      darkTheme: getAppThemeDark(),
      debugShowCheckedModeBanner: false,
      supportedLocales: const [
        Locale('ja', 'JP'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const MainPage(),
    );
  }
}
