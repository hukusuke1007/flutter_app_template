import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/provider.dart';
import '../res/theme.dart';
import '../widgets/have_scroll_bar_behavior.dart';
import 'start_up_page.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'テンプレアプリ', // TODO(shohei): アプリ名を設定
      useInheritedMediaQuery: true,

      /// スクロールバーをデフォルトで付与したい場合は設定する
      scrollBehavior: const HaveScrollBarBehavior(),

      theme: getAppTheme(),
      darkTheme: getAppThemeDark(),
      navigatorKey: ref.watch(navigatorKeyProvider),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ja', 'JP'),
      ],
      home: const StartUpPage(),
    );
  }
}
