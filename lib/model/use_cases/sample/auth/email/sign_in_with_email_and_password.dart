import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../exceptions/app_exception.dart';
import '../../../../../utils/logger.dart';
import '../../../../repositories/firebase_auth/auth_error_code.dart';
import '../../../../repositories/firebase_auth/firebase_auth_repository.dart';
import '../auth_state_controller.dart';

final signInWithEmailAndPasswordProvider =
    Provider(SignInWithEmailAndPassword.new);

class SignInWithEmailAndPassword {
  SignInWithEmailAndPassword(this._ref);

  final Ref _ref;

  Future<void> call({
    required String email,
    required String password,
  }) async {
    try {
      final repository = _ref.read(firebaseAuthRepositoryProvider);
      final authStateController =
          _ref.read(authStateControllerProvider.notifier);

      await repository.signInWithEmailAndPassword(email, password);

      authStateController.update(AuthState.signIn);
    } on FirebaseAuthException catch (e) {
      logger.shout(e);

      if (e.code == AuthErrorCode.invalidEmail.value ||
          e.code == AuthErrorCode.wrongPassword.value ||
          e.code == AuthErrorCode.userDisabled.value ||
          e.code == AuthErrorCode.userNotFound.value) {
        throw AppException(title: 'メールアドレスもしくはパスワードが正しくありません');
      } else {
        throw AppException(title: '不明なエラーです ${e.message}');
      }
    }
  }
}
