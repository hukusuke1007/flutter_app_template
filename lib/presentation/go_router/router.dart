import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/logger.dart';
import '../../utils/provider.dart';
import '../pages/error_page.dart';
import '../pages/main/main_page.dart';
import '../pages/sample/firestore_counter_page.dart';
import '../pages/sample/local_counter_page.dart';
import '../pages/sample/memo/memo_async_notifier_page.dart';
import '../pages/sample/memo/memo_state_notifier_page.dart';
import '../pages/start_up/start_up_page.dart';
import '../pages/web_view_page.dart';

final routerProvider = Provider((ref) {
  final navigatorKey = ref.watch(navigatorKeyProvider);
  return GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: StartUpPage.pagePath,
    debugLogDiagnostics: true,
    routes: [
      /// 起動画面
      GoRoute(
        path: StartUpPage.pagePath,
        name: StartUpPage.pageName,
        pageBuilder: (_, state) {
          return NoTransitionPage<void>(
            key: state.pageKey,
            child: const StartUpPage(),
          );
        },
      ),

      /// WebView
      GoRoute(
        path: WebViewPage.pagePath,
        name: WebViewPage.pageName,
        builder: (_, state) {
          final args = state.extra! as WebViewArgs;
          return WebViewPage(args: args);
        },
      ),

      /// メイン
      GoRoute(
        path: MainPage.pagePath,
        name: MainPage.pageName,
        pageBuilder: (_, state) {
          return NoTransitionPage<void>(
            key: state.pageKey,
            child: const MainPage(),
          );
        },
      ),

      /// ローカルカウンター
      GoRoute(
        path: LocalCounterPage.pagePath,
        name: LocalCounterPage.pageName,
        builder: (_, __) => const LocalCounterPage(),
      ),

      /// Firestoreカウンター
      GoRoute(
        path: FirestoreCounterPage.pagePath,
        name: FirestoreCounterPage.pageName,
        builder: (_, __) => const FirestoreCounterPage(),
      ),

      /// メモ（StateNotifier）
      GoRoute(
        path: MemoStateNotifierPage.pagePath,
        name: MemoStateNotifierPage.pageName,
        builder: (_, __) => const MemoStateNotifierPage(),
      ),

      /// メモ（AsyncNotifier）
      GoRoute(
        path: MemoAsyncNotifierPage.pagePath,
        name: MemoAsyncNotifierPage.pageName,
        builder: (_, __) => const MemoAsyncNotifierPage(),
      ),
    ],
    errorBuilder: (context, state) {
      logger.shout(state.error);
      return const ErrorPage();
    },
  );
});
