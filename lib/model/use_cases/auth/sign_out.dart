import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../utils/provider.dart';
import '../../repositories/firebase_auth/firebase_auth_repository.dart';

final signOutProvider = Provider((ref) => SignOut(ref.read));

class SignOut {
  SignOut(this._read);
  final Reader _read;

  Future<void> call() async {
    /// Firestoreのサインアウト前にStreamProvider経由のlistenを解除するため
    /// authStateProviderのstateを変更する cloud_firestore/permission-denied対策
    _read(authStateProvider.state).update((state) => AuthState.noSignIn);
    await _read(firebaseAuthRepositoryProvider).signOut();
  }
}
