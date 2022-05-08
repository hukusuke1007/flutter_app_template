import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../utils/constants.dart';
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
        case kAuthInvalidEmail:
        case kAuthMissingAndroidPkgName:
        case kAuthMissingContinueUri:
        case kAuthMissingIosBundleId:
        case kAuthInvalidContinueUri:
        case kAuthUnauthorizedContinueUri:
        case kAuthUserNotFound:
          throw AppException(title: '接続エラーが発生しました');
        default:
          throw AppException(title: '不明なエラーです ${e.message}');
      }
    }
  }
}
