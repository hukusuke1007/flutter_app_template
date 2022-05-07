import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app_template/model/exceptions/app_exception.dart';
import 'package:flutter_app_template/model/repositories/firebase_auth/firebase_auth_repository.dart';
import 'package:flutter_app_template/model/use_cases/auth/auth_state.dart';
import 'package:flutter_app_template/utils/logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final createUserWithEmailAndPasswordProvider =
    Provider.autoDispose((ref) => CreateUserWithEmailAndPassword(ref.read));

class CreateUserWithEmailAndPassword {
  CreateUserWithEmailAndPassword(this._read);

  final Reader _read;

  Future<void> call(String email, String password) async {
    try {
      final repository = _read(firebaseAuthRepositoryProvider);
      final controller = _read(authProvider.state);

      await repository.createUserWithEmailAndPassword(email, password);
      // NOTE: メールアドレスの確認を完了させるまではsignInに変更しない
      controller.update((state) => AuthState.noSignIn);

      logger.info('Emailサインアップに成功しました');
    } on FirebaseAuthException catch (e) {
      logger.shout(e);

      switch (e.code) {

        /// メールアドレスは既に存在する
        case 'email-already-in-use':
          throw AppException(title: 'このアカウントは既に存在します');

        /// メールアドレスが正しくない
        case 'invalid-email':
          throw AppException(title: 'メールアドレスが正しくありません');

        /// メールアドレス/パスワードのアカウントが有効でない
        /// FirebaseコンソールのAuthタブでメールアドレス認証を有効にする必要がある
        case 'operation-not-allowed':
          throw AppException(title: '接続エラーが発生しました');

        /// パスワードが十分に強力でない
        case 'weak-password':
          throw AppException(title: '安全性が低いパスワードです');
      }
    }
  }
}