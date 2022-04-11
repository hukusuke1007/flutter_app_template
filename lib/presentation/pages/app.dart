import 'package:flutter/material.dart';
import 'package:flutter_app_template/model/use_cases/go_router/route_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../res/theme.dart';

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 以下、go_router用
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      theme: getAppTheme(),
      darkTheme: getAppThemeDark(),
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ja', 'JP'),
      ],
    );

    // return MaterialApp(
    //   title: 'テンプレアプリ', // TODO(shohei): アプリ名を設定
    //   useInheritedMediaQuery: true,
    //   locale: DevicePreview.locale(context),
    //   builder: DevicePreview.appBuilder,
    //   theme: getAppTheme(),
    //   darkTheme: getAppThemeDark(),
    //   navigatorKey: ref.watch(navigatorKeyProvider),
    //   debugShowCheckedModeBanner: false,
    //   localizationsDelegates: const [
    //     GlobalMaterialLocalizations.delegate,
    //     GlobalWidgetsLocalizations.delegate,
    //     GlobalCupertinoLocalizations.delegate,
    //   ],
    //   supportedLocales: const [
    //     Locale('ja', 'JP'),
    //   ],
    //   home: const StartUpPage(),
    // );
  }
}
