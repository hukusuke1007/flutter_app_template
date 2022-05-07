import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app_template/model/exceptions/app_exception.dart';
import 'package:flutter_app_template/model/repositories/firebase_auth/firebase_auth_repository.dart';
import 'package:flutter_app_template/model/use_cases/auth/auth_state.dart';
import 'package:flutter_app_template/utils/logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final signInWithEmailAndPasswordProvider =
    Provider.autoDispose((ref) => SignInWithEmailAndPassword(ref.read));

class SignInWithEmailAndPassword {
  SignInWithEmailAndPassword(this._read);

  final Reader _read;

  Future<void> call(String email, String password) async {
    try {
      final repository = _read(firebaseAuthRepositoryProvider);
      final controller = _read(authProvider.state);

      await repository.signInWithEmailAndPassword(email, password);

      final user = _read(firebaseAuthRepositoryProvider).authUser;
      if (user != null && user.emailVerified) {
        controller.update((state) => AuthState.signIn);
      } else {
        controller.update((state) => AuthState.noSignIn);
      }

      logger.info('Emailサインインに成功しました。');
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
