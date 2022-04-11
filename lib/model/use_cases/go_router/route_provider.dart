import 'package:flutter_app_template/presentation/pages/sample/go_router/bottom_navigation_tab.dart';
import 'package:flutter_app_template/presentation/pages/sample/go_router/go_router_page.dart';
import 'package:flutter_app_template/presentation/widgets/go_router_location_button.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final routerProvider = Provider(
  (ref) => GoRouter(
    debugLogDiagnostics: true,
    restorationScopeId: 'router',
    routes: [
      GoRoute(
        path: '/',
        redirect: (_) => '/goRouter/tab1',
      ),
      GoRoute(
        path: '/goRouter/:id',
        builder: (context, state) {
          final id = state.params['id'];
          final index = BottomNavigationTabExt.fromId(id!).order;
          return GoRouterPage(currentPageIndex: index);
        },
      )
    ],
    // 右下にパス表示・指定できる独自ボタン配置
    navigatorBuilder: (_, __, child) => GoRouterLocationButton(
      child: child,
    ),
  ),
);
