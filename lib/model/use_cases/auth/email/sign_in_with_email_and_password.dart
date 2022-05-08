import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../utils/constants.dart';
import '../../../../utils/logger.dart';
import '../../../../utils/provider.dart';
import '../../../exceptions/app_exception.dart';
import '../../../repositories/firebase_auth/firebase_auth_repository.dart';

final signInWithEmailAndPasswordProvider =
    Provider((ref) => SignInWithEmailAndPassword(ref.read));

class SignInWithEmailAndPassword {
  SignInWithEmailAndPassword(this._read);

  final Reader _read;

  Future<void> call(String email, String password) async {
    try {
      final repository = _read(firebaseAuthRepositoryProvider);
      final authState = _read(authStateProvider.state);

      await repository.signInWithEmailAndPassword(email, password);

      final user = _read(firebaseAuthRepositoryProvider).authUser;
      if (user != null && user.emailVerified) {
        authState.update((state) => AuthState.signIn);
      } else {
        authState.update((state) => AuthState.noSignIn);
      }

      logger.info('Emailサインインに成功しました');
    } on FirebaseAuthException catch (e) {
      logger.shout(e);

      switch (e.code) {
        case kInvalidEmail:
        case kWrongPassword:
        case kUserDisabled:
        case kUserNotFound:
          throw AppException(title: 'メールアドレスもしくはパスワードが正しくありません');
        default:
          throw AppException(title: '不明なエラーです ${e.message}');
      }
    }
  }
}
