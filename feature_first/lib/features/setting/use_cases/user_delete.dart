import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/repositories/firebase_auth/firebase_auth_repository.dart';
import '../../../core/use_cases/authentication/auth_state_controller.dart';

part 'user_delete.g.dart';

@Riverpod(keepAlive: true)
UserDelete userDelete(Ref ref) {
  return UserDelete(ref);
}

class UserDelete {
  UserDelete(this._ref);
  final Ref _ref;

  Future<void> call(User user) async {
    await _ref.read(firebaseAuthRepositoryProvider).userDelete(user);
    _ref.read(authStateControllerProvider.notifier).update(AuthState.noSignIn);
  }
}
