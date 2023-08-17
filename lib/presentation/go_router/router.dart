import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../model/use_cases/sample/timeline/post/fetch_post.dart';
import '../../utils/logger.dart';
import '../../utils/provider.dart';
import '../pages/error/error_page.dart';
import '../pages/main/main_page.dart';
import '../pages/sample/auth_with_email/change_email_address_page.dart';
import '../pages/sample/auth_with_email/change_email_password_page.dart';
import '../pages/sample/auth_with_email/email_verification_page.dart';
import '../pages/sample/auth_with_email/reset_email_password_page.dart';
import '../pages/sample/auth_with_email/sign_in_with_email_page.dart';
import '../pages/sample/auth_with_email/sign_up_with_email_page.dart';
import '../pages/sample/auth_with_email/top_email_feature_page.dart';
import '../pages/sample/firestore_counter/firestore_counter_page.dart';
import '../pages/sample/local_counter/local_counter_page.dart';
import '../pages/sample/memo/memo_async_notifier_page.dart';
import '../pages/sample/memo/memo_state_notifier_page.dart';
import '../pages/sample/timeline/edit_post_page.dart';
import '../pages/sample/timeline/post_detail_page.dart';
import '../pages/sample/timeline/timeline_page.dart';
import '../pages/start_up/start_up_page.dart';
import '../pages/web_view/web_view_page.dart';
import 'transition_observer.dart';

// TODO(shohei): StatefulShellRoute は未対応
final routerProvider = Provider((ref) {
  final navigatorKey = ref.watch(navigatorKeyProvider);
  final transitionObserver = ref.watch(transitionObserverProvider);
  return GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: StartUpPage.pagePath,
    debugLogDiagnostics: true,
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
            builder: (_, __) => const LocalCounterPage(),
          ),

          /// Firestoreカウンター
          GoRoute(
            path: FirestoreCounterPage.pageName,
            name: FirestoreCounterPage.pageName,
            builder: (_, __) => const FirestoreCounterPage(),
          ),

          /// メールアドレス認証
          GoRoute(
            path: TopEmailFeaturePage.pageName,
            name: TopEmailFeaturePage.pageName,
            builder: (_, __) => const TopEmailFeaturePage(),
            routes: [
              /// サインアップ
              GoRoute(
                path: SignUpWithEmailPage.pageName,
                name: SignUpWithEmailPage.pageName,
                builder: (_, __) => const SignUpWithEmailPage(),
              ),

              /// サインイン
              GoRoute(
                path: SignInWithEmailPage.pageName,
                name: SignInWithEmailPage.pageName,
                builder: (_, __) => const SignInWithEmailPage(),
              ),

              /// パスワード変更
              GoRoute(
                path: ChangeEmailPasswordPage.pageName,
                name: ChangeEmailPasswordPage.pageName,
                builder: (_, __) => const ChangeEmailPasswordPage(),
              ),

              /// パスワードリセット
              GoRoute(
                path: ResetEmailPasswordPage.pageName,
                name: ResetEmailPasswordPage.pageName,
                builder: (_, __) => const ResetEmailPasswordPage(),
              ),

              /// メールアドレスの変更
              GoRoute(
                path: ChangeEmailAddressPage.pageName,
                name: ChangeEmailAddressPage.pageName,
                builder: (_, __) => const ChangeEmailAddressPage(),
              ),

              /// メールアドレス本人認証
              GoRoute(
                path: EmailVerificationPage.pageName,
                name: EmailVerificationPage.pageName,
                builder: (_, __) => const EmailVerificationPage(),
              ),
            ],
          ),

          /// タイムライン
          GoRoute(
            path: TimelinePage.pageName,
            name: TimelinePage.pageName,
            builder: (_, __) => const TimelinePage(),
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
                  final args = state.extra! as FetchPostArgs;
                  return PostDetailPage(args: args);
                },
              ),
            ],
          ),

          /// メモ（StateNotifier）
          GoRoute(
            path: MemoStateNotifierPage.pageName,
            name: MemoStateNotifierPage.pageName,
            builder: (_, __) => const MemoStateNotifierPage(),
          ),

          /// メモ（AsyncNotifier）
          GoRoute(
            path: MemoAsyncNotifierPage.pageName,
            name: MemoAsyncNotifierPage.pageName,
            builder: (_, __) => const MemoAsyncNotifierPage(),
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
