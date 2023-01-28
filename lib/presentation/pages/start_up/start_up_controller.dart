import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../model/repositories/firebase_auth/login_type.dart';
import '../../../model/use_cases/auth/fetch_logged_in_type.dart';
import '../../../model/use_cases/auth/sign_in_with_anonymously.dart';
import '../../../utils/provider.dart';

enum StartUpResultType {
  success,
  forcedVersionUpgrade,
}

final startUpControllerProvider =
    FutureProvider.autoDispose<StartUpResultType>((ref) async {
  final loginType = ref.read(fetchLoggedInTypeProvider)();
  if (loginType != null) {
    ref.read(authStateProvider.notifier).update(
          (state) => loginType == LoginType.anonymously
              ? AuthState.signInWithAnonymously
              : AuthState.signIn,
        );
  } else {
    await ref.read(signInWithAnonymouslyProvider)();
  }

  // TODO(shohei): 強制バージョンアップを実装する場合はここで確認して StartUpResultType.forcedVersionUpgrade を返却する

  return StartUpResultType.success;
});
