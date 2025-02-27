import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_template/features/aggregation/pages/firestore_aggregation_page.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../features/features.dart';
import '../utils/logger.dart';
import '../utils/navigator_key_provider.dart';
import 'transition_observer.dart';

// TODO(shohei): StatefulShellRoute は未対応
final routerProvider = Provider<GoRouter>((ref) {
  final navigatorKey = ref.watch(navigatorKeyProvider);
  final transitionObserver = ref.watch(transitionObserverProvider);
  return GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: StartUpPage.pagePath,
    debugLogDiagnostics: kDebugMode,
    observers: [transitionObserver],
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
        routes: [
          /// ローカルカウンター
          GoRoute(
            path: LocalCounterPage.pageName,
            name: LocalCounterPage.pageName,
            builder: (_, _) => const LocalCounterPage(),
          ),

          /// Firestoreカウンター
          GoRoute(
            path: FirestoreCounterPage.pageName,
            name: FirestoreCounterPage.pageName,
            builder: (_, _) => const FirestoreCounterPage(),
          ),

          /// メールアドレス認証
          GoRoute(
            path: TopEmailFeaturePage.pageName,
            name: TopEmailFeaturePage.pageName,
            builder: (_, _) => const TopEmailFeaturePage(),
            routes: [
              /// サインアップ
              GoRoute(
                path: SignUpWithEmailPage.pageName,
                name: SignUpWithEmailPage.pageName,
                builder: (_, _) => const SignUpWithEmailPage(),
              ),

              /// サインイン
              GoRoute(
                path: SignInWithEmailPage.pageName,
                name: SignInWithEmailPage.pageName,
                builder: (_, _) => const SignInWithEmailPage(),
              ),

              /// パスワード変更
              GoRoute(
                path: ChangeEmailPasswordPage.pageName,
                name: ChangeEmailPasswordPage.pageName,
                builder: (_, _) => const ChangeEmailPasswordPage(),
              ),

              /// パスワードリセット
              GoRoute(
                path: ResetEmailPasswordPage.pageName,
                name: ResetEmailPasswordPage.pageName,
                builder: (_, _) => const ResetEmailPasswordPage(),
              ),

              /// メールアドレスの変更
              GoRoute(
                path: ChangeEmailAddressPage.pageName,
                name: ChangeEmailAddressPage.pageName,
                builder: (_, _) => const ChangeEmailAddressPage(),
              ),

              /// メールアドレス本人認証
              GoRoute(
                path: EmailVerificationPage.pageName,
                name: EmailVerificationPage.pageName,
                builder: (_, _) => const EmailVerificationPage(),
              ),
            ],
          ),

          /// Firestore Aggregation
          GoRoute(
            path: FirestoreAggregationPage.pageName,
            name: FirestoreAggregationPage.pageName,
            builder: (_, _) => const FirestoreAggregationPage(),
          ),

          /// タイムライン
          GoRoute(
            path: TimelinePage.pageName,
            name: TimelinePage.pageName,
            builder: (_, _) => const TimelinePage(),
            routes: [
              /// 投稿の作成・更新・削除
              GoRoute(
                path: EditPostPage.pageName,
                name: EditPostPage.pageName,
                pageBuilder: (_, state) {
                  final args = state.extra as EditPostPageArgs?;
                  return MaterialPage(
                    key: state.pageKey,
                    fullscreenDialog: true,
                    child: EditPostPage(args: args),
                  );
                },
              ),

              /// 投稿詳細
              GoRoute(
                path: PostDetailPage.pageName,
                name: PostDetailPage.pageName,
                builder: (_, state) {
                  final args = state.extra! as (String posterId, String postId);
                  return PostDetailPage(posterId: args.$1, postId: args.$2);
                },
              ),
            ],
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
