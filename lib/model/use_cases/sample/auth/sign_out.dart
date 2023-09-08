import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../exceptions/app_exception.dart';
import '../../../../utils/logger.dart';
import '../../../repositories/firebase_auth/firebase_auth_repository.dart';
import 'auth_state_controller.dart';

final signOutProvider = Provider(SignOut.new);

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
