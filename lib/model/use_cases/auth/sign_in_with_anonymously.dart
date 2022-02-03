import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../repositories/firebase_auth/firebase_auth_repository.dart';

final signInWithAnonymously =
    Provider((ref) => SignInWithAnonymously(ref.read));

class SignInWithAnonymously {
  SignInWithAnonymously(this._read);
  final Reader _read;

  Future<User?> call() async {
    final userCredential =
        await _read(firebaseAuthRepositoryProvider).signInWithAnonymously();
    return userCredential.user;
  }
}
