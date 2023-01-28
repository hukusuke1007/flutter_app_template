import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../utils/provider.dart';
import '../../../repositories/firebase_auth/firebase_auth_repository.dart';

final signInWithAnonymouslyProvider = Provider(SignInWithAnonymously.new);

class SignInWithAnonymously {
  SignInWithAnonymously(this._ref);
  final Ref _ref;

  Future<User?> call() async {
    final userCredential =
        await _ref.read(firebaseAuthRepositoryProvider).signInWithAnonymously();
    _ref
        .read(authStateProvider.notifier)
        .update((state) => AuthState.signInWithAnonymously);
    return userCredential.user;
  }
}
