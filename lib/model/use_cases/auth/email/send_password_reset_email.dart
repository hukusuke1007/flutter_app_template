import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../utils/logger.dart';
import '../../../exceptions/app_exception.dart';
import '../../../repositories/firebase_auth/firebase_auth_repository.dart';

final sendPasswordResetEmailProvider =
    Provider((ref) => SendPasswordResetEmail(ref.read));

class SendPasswordResetEmail {
  SendPasswordResetEmail(this._read);
  final Reader _read;

  Future<void> call(String email) async {
    try {
      final repository = _read(firebaseAuthRepositoryProvider);
      await repository.sendPasswordResetEmail(email);

      logger.info('パスワード再設定メールを送信しました');
    } on FirebaseAuthException catch (e) {
      logger.shout(e);

      switch (e.code) {

        /// メールアドレスが有効でない
        case 'auth/invalid-email':

        /// Androidアプリのインストールが必要
        case 'auth/missing-android-pkg-name':

        /// リクエストに続行URLの指定が必要
        case 'auth/missing-continue-uri':

        /// App Store IDが提供されている場合、iOSバンドルIDが必要
        case 'auth/missing-ios-bundle-id':

        /// リクエストで提供された続行URLが無効
        case 'auth/invalid-continue-uri':

        /// 続行URLのドメインがホワイトリストに登録されていない
        /// Firebaseコンソールでドメインをホワイトリストに登録する必要がある
        case 'auth/unauthorized-continue-uri':

        /// メールアドレスに対応するユーザーが存在しない
        case 'auth/user-not-found':
          throw AppException(title: '接続エラーが発生しました');
      }
    }
  }
}
