import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/repositories/firebase_auth/firebase_auth_repository.dart';
import '../../../core/repositories/firestore/document_repository.dart';
import '../../../core/use_cases/authentication/auth_state_controller.dart';
import '../entities/counter.dart';

part 'fetch_firestore_counter_stream.g.dart';

/// 取得（スナップショットリスナー使用）
@riverpod
class FetchFirestoreCounter extends _$FetchFirestoreCounter {
  @override
  Stream<Counter?> build() {
    final authState = ref.watch(authStateControllerProvider);
    if (authState == AuthState.noSignIn) {
      return Stream.value(null);
    }
    final userId = ref.watch(firebaseAuthRepositoryProvider).loggedInUserId;
    if (userId == null) {
      return Stream.value(null);
    }
    return ref
        .watch(documentRepositoryProvider)
        .snapshots(Counter.docPath(userId))
        .map((event) {
      final data = event.data();
      return data != null ? Counter.fromJson(data) : null;
    });
  }
}
