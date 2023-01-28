import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../exceptions/app_exception.dart';
import '../../../../../utils/logger.dart';
import '../../../../repositories/firebase_auth/auth_error_code.dart';
import '../../../../repositories/firebase_auth/firebase_auth_repository.dart';

final changeEmailPasswordProvider = Provider(ChangeEmailPassword.new);

class ChangeEmailPassword {
  ChangeEmailPassword(this._ref);

  final Ref _ref;

  Future<void> call({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final repository = _ref.read(firebaseAuthRepositoryProvider);
      final email = repository.authUser?.email;
      if (email == null) {
        throw AppException(title: 'ログインしてください');
      }
      await repository.changeEmailPassword(
        email: email,
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
    } on FirebaseAuthException catch (e) {
      logger.shout(e);

      if (e.code == AuthErrorCode.authInvalidEmail.value ||
          e.code == AuthErrorCode.authMissingAndroidPkgName.value ||
          e.code == AuthErrorCode.authMissingContinueUri.value ||
          e.code == AuthErrorCode.authMissingIosBundleId.value ||
          e.code == AuthErrorCode.authInvalidContinueUri.value ||
          e.code == AuthErrorCode.authUnauthorizedContinueUri.value ||
          e.code == AuthErrorCode.authUserNotFound.value) {
        throw AppException(title: 'エラーが発生しました');
      } else {
        throw AppException(title: '不明なエラーです ${e.message}');
      }
    }
  }
}
