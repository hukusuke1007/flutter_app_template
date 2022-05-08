import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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

        /// メールアドレスが有効でない
        case 'invalid-email':

        /// メールアドレスのパスワードが間違っている場合、
        /// または、メールアドレスに対応するユーザーがパスワードを設定していない場合
        case 'wrong-password':

        /// メールアドレスに対応するユーザーが無効
        case 'user-disabled':

        /// メールアドレスに対応するユーザーが存在しない
        case 'user-not-found':
          throw AppException(title: 'メールアドレスもしくはパスワードが正しくありません');
      }
    }
  }
}
