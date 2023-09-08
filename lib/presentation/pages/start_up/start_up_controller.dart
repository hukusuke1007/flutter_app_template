import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../model/use_cases/sample/auth/fetch_logged_in_type.dart';
import '../../../model/use_cases/sample/auth/sign_in_with_anonymously.dart';
import '../../../utils/logger.dart';

enum StartUpResultType {
  success,
  forcedVersionUpgrade,
}

final startUpControllerProvider =
    FutureProvider.autoDispose<StartUpResultType>((ref) async {
  /// ログイン状態を確認
  final loginType = ref.read(fetchLoggedInTypeProvider)();
  logger.info(loginType);

  if (loginType == null) {
    /// ログインしていなければ匿名認証でログインする
    await ref.read(signInWithAnonymouslyProvider)();
  }

  // TODO(shohei): 強制バージョンアップを実装する場合はここで確認して StartUpResultType.forcedVersionUpgrade を返却する

  return StartUpResultType.success;
});
