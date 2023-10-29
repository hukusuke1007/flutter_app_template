import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../exceptions/app_exception.dart';
import '../../../../../utils/logger.dart';
import '../../../../repositories/firebase_auth/auth_error_code.dart';
import '../../../../repositories/firebase_auth/firebase_auth_repository.dart';
import '../auth_state_controller.dart';

final signUpWithEmailAndPasswordProvider =
    Provider(SignUpWithEmailAndPassword.new);

class SignUpWithEmailAndPassword {
  SignUpWithEmailAndPassword(this._ref);

  final Ref _ref;

  Future<void> call({
    required String email,
    required String password,
  }) async {
    try {
      final repository = _ref.read(firebaseAuthRepositoryProvider);
      final authStateController =
          _ref.read(authStateControllerProvider.notifier);

      await repository.createUserWithEmailAndPassword(email, password);

      authStateController.update(AuthState.signIn);

      logger.info('Emailサインアップに成功しました');
    } on FirebaseAuthException catch (e) {
      logger.shout(e);

      if (e.code == AuthErrorCode.emailAlreadyInUse.value) {
        throw AppException(title: 'このアカウントは既に存在します');
      } else if (e.code == AuthErrorCode.invalidEmail.value) {
        throw AppException(title: 'メールアドレスが正しくありません');
      } else if (e.code == AuthErrorCode.operationNotAllowed.value) {
        throw AppException(title: '接続エラーが発生しました');
      } else if (e.code == AuthErrorCode.weakPassword.value) {
        throw AppException(title: '安全性が低いパスワードです');
      } else {
        throw AppException(title: '不明なエラーです ${e.message}');
      }
    }
  }
}
