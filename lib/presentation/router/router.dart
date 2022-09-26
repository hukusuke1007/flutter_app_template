import 'package:flutter_app_template/presentation/pages/error_page.dart';
import 'package:flutter_app_template/presentation/pages/main/main_page.dart';
import 'package:flutter_app_template/presentation/pages/sample/firestore_counter_page.dart';
import 'package:flutter_app_template/presentation/pages/sample/home/home_page.dart';
import 'package:flutter_app_template/presentation/pages/sample/local_counter_page.dart';
import 'package:flutter_app_template/presentation/pages/sample/memo/memo_page.dart';
import 'package:flutter_app_template/presentation/pages/sample/setting/setting_page.dart';
import 'package:flutter_app_template/presentation/pages/start_up_page.dart';
import 'package:flutter_app_template/utils/logger.dart';
import 'package:flutter_app_template/utils/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../pages/sample/github_users/with_state_notifier/github_users_page.dart';
import '../pages/web_view_page.dart';

final routerProvider = Provider((ref) {
  final navigatorKey = ref.watch(navigatorKeyProvider);
  return GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: StartUpPage.pagePath,
    debugLogDiagnostics: true,
    routes: [
      /// スタートアップ画面
      GoRoute(
        path: StartUpPage.pagePath,
        builder: (_, __) => const StartUpPage(),
      ),

      /// WebView画面
      GoRoute(
        path: WebViewPage.pagePath,
        builder: (_, state) {
          final args = state.extra! as WebViewArgs;
          return WebViewPage(args);
        },
      ),

      /// ボトムタブ画面
      /// 参考
      /// https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/shell_route.dart
      ShellRoute(
        builder: (_, state, child) {
          return MainPage(child);
        },
        routes: [
          /// タブ1
          GoRoute(
            path: HomePage.pagePath,
            pageBuilder: (context, state) {
              return NoTransitionPage<void>(
                key: state.pageKey,
                child: const HomePage(),
              );
            },
            routes: <RouteBase>[
              GoRoute(
                path: LocalCounterPage.pageName,
                builder: (context, state) {
                  return const LocalCounterPage();
                },
              ),
              GoRoute(
                path: FirestoreCounterPage.pageName,
                builder: (context, state) {
                  return const FirestoreCounterPage();
                },
              ),
            ],
          ),

          /// タブ2
          GoRoute(
            path: GithubUsersPage.pagePath,
            pageBuilder: (context, state) {
              return NoTransitionPage<void>(
                key: state.pageKey,
                child: const GithubUsersPage(),
              );
            },
          ),

          /// タブ3
          GoRoute(
            path: MemoPage.pagePath,
            pageBuilder: (context, state) {
              return NoTransitionPage<void>(
                key: state.pageKey,
                child: const MemoPage(),
              );
            },
          ),

          /// タブ4
          GoRoute(
            path: SettingPage.pagePath,
            pageBuilder: (context, state) {
              return NoTransitionPage<void>(
                key: state.pageKey,
                child: const SettingPage(),
              );
            },
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) {
      logger.shout(state.error);
      return const ErrorPage();
    },
  );
});
