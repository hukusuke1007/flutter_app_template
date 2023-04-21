import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TabNavigatorRoutes {
  static const String root = '/';
}

class TabNavigator extends ConsumerWidget {
  const TabNavigator({
    super.key,
    required this.navigatorKey,
    required this.page,
  });

  final GlobalKey<NavigatorState> navigatorKey;
  final Widget page;

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
    return {
      TabNavigatorRoutes.root: (context) => page,
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routeBuilders = _routeBuilders(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: TabNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute<void>(
          builder: routeBuilders[routeSettings.name]!,
        );
      },
    );
  }
}
