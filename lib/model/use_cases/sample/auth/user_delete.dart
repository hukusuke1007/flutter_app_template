import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../utils/provider.dart';
import '../../../repositories/firebase_auth/firebase_auth_repository.dart';

final userDeleteProvider = Provider(UserDelete.new);

class UserDelete {
  UserDelete(this._ref);
  final Ref _ref;

  Future<void> call(User user) async {
    /// Firestoreのサインアウト・認証情報削除前にStreamProvider経由のlistenを解除するため
    /// authStateProviderのstateを変更する cloud_firestore/permission-denied対策
    final oldAuthState = _ref.read(authStateProvider.notifier).state;
    _ref.read(authStateProvider.notifier).update((state) => AuthState.noSignIn);
    try {
      await _ref.read(firebaseAuthRepositoryProvider).userDelete(user);
    } on Exception catch (_) {
      /// エラーが発生した場合はauthStateProviderの状態を元に戻す
      _ref.read(authStateProvider.notifier).update((state) => oldAuthState);
      rethrow;
    }
  }
}
