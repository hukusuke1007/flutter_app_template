import 'package:flutter_app_template/presentation/go_router/modal_transition_page.dart';
import 'package:flutter_app_template/presentation/pages/sample/timeline/edit_post_page.dart';
import 'package:flutter_app_template/presentation/pages/sample/timeline/timeline_page.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../model/entities/sample/timeline/post.dart';
import '../../model/use_cases/sample/timeline/post/fetch_post.dart';
import '../../utils/logger.dart';
import '../../utils/provider.dart';
import '../pages/error_page.dart';
import '../pages/main/main_page.dart';
import '../pages/sample/auth_with_email/change_email_address_page.dart';
import '../pages/sample/auth_with_email/change_email_password_page.dart';
import '../pages/sample/auth_with_email/email_verification_page.dart';
import '../pages/sample/auth_with_email/reset_email_password_page.dart';
import '../pages/sample/auth_with_email/sign_in_with_email_page.dart';
import '../pages/sample/auth_with_email/sign_up_with_email_page.dart';
import '../pages/sample/auth_with_email/top_email_feature_page.dart';
import '../pages/sample/firestore_counter_page.dart';
import '../pages/sample/local_counter_page.dart';
import '../pages/sample/memo/memo_async_notifier_page.dart';
import '../pages/sample/memo/memo_state_notifier_page.dart';
import '../pages/sample/timeline/post_detail_page.dart';
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

      /// メールアドレス認証
      GoRoute(
        path: TopEmailFeaturePage.pagePath,
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

          /// メールアドレス変更
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
        path: TimelinePage.pagePath,
        name: TimelinePage.pageName,
        builder: (_, __) => const TimelinePage(),
        routes: [
          /// 投稿の作成・更新・削除
          GoRoute(
            path: EditPostPage.pageName,
            name: EditPostPage.pageName,
            pageBuilder: (_, state) {
              final args = state.extra as Post?;
              return ModalTransitionPage<void>(
                key: state.pageKey,
                child: EditPostPage(oldPost: args),
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
    ],
    errorBuilder: (context, state) {
      logger.shout(state.error);
      return const ErrorPage();
    },
  );
});
