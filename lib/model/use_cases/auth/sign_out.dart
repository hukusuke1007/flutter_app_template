import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../utils/provider.dart';
import '../../repositories/firebase_auth/firebase_auth_repository.dart';

final signOut = Provider((ref) => SignOut(ref.read));

class SignOut {
  SignOut(this._read);
  final Reader _read;

  Future<void> call() async {
    await _read(firebaseAuthRepositoryProvider).signOut();
    _read(authStateProvider.state).state = AuthState.noSignIn;
  }
}
