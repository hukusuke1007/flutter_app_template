import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../exceptions/app_exception.dart';
import '../../../../../utils/logger.dart';
import '../../../../repositories/firebase_auth/auth_error_code.dart';
import '../../../../repositories/firebase_auth/firebase_auth_repository.dart';

final sendEmailVerificationProvider = Provider(SendEmailVerification.new);

class SendEmailVerification {
  SendEmailVerification(this._ref);

  final Ref _ref;

  Future<void> call() async {
    try {
      final repository = _ref.read(firebaseAuthRepositoryProvider);
      await repository.sendEmailVerification();
    } on FirebaseException catch (e) {
      logger.shout(e);

      if (e.code == AuthErrorCode.missingEmail.value) {
        throw AppException(title: 'メールアドレスでログインしてください');
      } else {
        throw AppException(title: '不明なエラーです ${e.message}');
      }
    }
  }
}
