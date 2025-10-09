import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/repositories/firebase_auth/firebase_auth_repository.dart';
import '../../../core/use_cases/authentication/auth_state_controller.dart';

part 'sign_in_with_anonymously.g.dart';

@Riverpod(keepAlive: true)
SignInWithAnonymously signInWithAnonymously(Ref ref) {
  return SignInWithAnonymously(ref);
}

class SignInWithAnonymously {
  SignInWithAnonymously(this._ref);
  final Ref _ref;

  Future<User?> call() async {
    final userCredential = await _ref
        .read(firebaseAuthRepositoryProvider)
        .signInWithAnonymously();
    _ref
        .read(authStateControllerProvider.notifier)
        .update(AuthState.signInWithAnonymously);
    return userCredential.user;
  }
}
