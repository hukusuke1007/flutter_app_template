import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../utils/provider.dart';
import '../../../entities/sample/counter.dart';
import '../../../repositories/firebase_auth/firebase_auth_repository.dart';
import '../../../repositories/firestore/document_repository.dart';

/// 取得（スナップショットリスナー使用）
final fetchFirestoreCounterProvider =
    StreamNotifierProvider.autoDispose<FetchFirestoreCounter, Counter?>(() {
  return FetchFirestoreCounter();
});

class FetchFirestoreCounter extends AutoDisposeStreamNotifier<Counter?> {
  @override
  Stream<Counter?> build() {
    final authState = ref.watch(authStateProvider);
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
