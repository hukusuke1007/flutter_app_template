import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/exceptions/app_exception.dart';
import '../../../core/repositories/firebase_auth/firebase_auth_repository.dart';
import '../../../core/use_cases/authentication/auth_state_controller.dart';
import '../../../core/utils/logger.dart';

part 'sign_out.g.dart';

@Riverpod(keepAlive: true)
SignOut signOut(Ref ref) {
  return SignOut(ref);
}

class SignOut {
  SignOut(this._ref);

  final Ref _ref;

  Future<void> call() async {
    try {
      await _ref.read(firebaseAuthRepositoryProvider).signOut();
      _ref
          .read(authStateControllerProvider.notifier)
          .update(AuthState.noSignIn);
    } on Exception catch (e) {
      logger.shout(e);
      throw AppException(title: 'サインアウトに失敗しました');
    }
  }
}
