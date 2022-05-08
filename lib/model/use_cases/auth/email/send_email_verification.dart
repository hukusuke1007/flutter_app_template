import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app_template/model/exceptions/app_exception.dart';
import 'package:flutter_app_template/model/repositories/firebase_auth/firebase_auth_repository.dart';
import 'package:flutter_app_template/utils/logger.dart';
import 'package:flutter_app_template/utils/provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final sendEmailVerificationProvider =
    Provider.autoDispose((ref) => SendEmailVerification(ref.read));

class SendEmailVerification {
  SendEmailVerification(this._read);
  final Reader _read;

  Future<void> call() async {
    final repository = _read(firebaseAuthRepositoryProvider);
    final controller = _read(authStateProvider.state);

    final user = repository.authUser;
    if (user == null) {
      throw AppException(title: 'ログインしてください');
    }

    try {
      await repository.sendEmailVerification(user);
      controller.update((state) => AuthState.noSignIn);

      logger.info('確認メールを送信しました');
    } on FirebaseException catch (e) {
      logger.shout(e);

      switch (e.code) {
        case 'missing-email':
          throw AppException(title: 'メールアドレスでログインしてください');
      }
    }
  }
}
