import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../model/repositories/firebase_auth/login_type.dart';
import '../../../model/use_cases/sample/auth/fetch_logged_in_type.dart';
import '../../../model/use_cases/sample/auth/sign_in_with_anonymously.dart';
import '../../../utils/provider.dart';

enum StartUpResultType {
  success,
  forcedVersionUpgrade,
}

final startUpControllerProvider =
    FutureProvider.autoDispose<StartUpResultType>((ref) async {
  /// ログイン状態を確認
  final loginType = ref.read(fetchLoggedInTypeProvider)();
  if (loginType != null) {
    /// アプリ内の認証状態を設定する
    ref.read(authStateProvider.notifier).update(
          (state) => loginType == LoginType.anonymously
              ? AuthState.signInWithAnonymously
              : AuthState.signIn,
        );
  } else {
    /// ログインしていなければ匿名認証でログインする
    await ref.read(signInWithAnonymouslyProvider)();
  }

  // TODO(shohei): 強制バージョンアップを実装する場合はここで確認して StartUpResultType.forcedVersionUpgrade を返却する

  return StartUpResultType.success;
});
