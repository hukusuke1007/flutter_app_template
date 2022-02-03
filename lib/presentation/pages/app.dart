import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/provider.dart';
import '../res/theme.dart';

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const locale = Locale('ja', 'JP');

    return MaterialApp(
      title: '世界遺産ウォーキング',
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
      home: const SizedBox.shrink(),
    );
  }
}
