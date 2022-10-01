import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../exceptions/app_exception.dart';
import '../../../utils/provider.dart';
import '../../entities/sample/counter.dart';
import '../../repositories/firebase_auth/firebase_auth_repository.dart';
import '../../repositories/firestore/document_repository.dart';

/// 取得（スナップショットリスナー未使用）
final fetchFirestoreCounterProvider = Provider(FetchFirestoreCounter.new);

class FetchFirestoreCounter {
  FetchFirestoreCounter(this._ref);
  final Ref _ref;

  Future<Counter?> call() async {
    final userId = _ref.read(firebaseAuthRepositoryProvider).loggedInUserId;
    if (userId == null) {
      throw AppException(title: 'ログインしてください');
    }
    final doc = await _ref.read(documentRepositoryProvider).fetch<Counter>(
          Counter.docPath(userId),
          decode: Counter.fromJson,
        );
    return doc.entity;
  }
}

/// 取得（スナップショットリスナー使用）
final fetchFirestoreCounterStreamProvider = StreamProvider<Counter?>((ref) {
  final authState = ref.watch(authStateProvider);
  if (authState == AuthState.noSignIn) {
    return Stream.value(null);
  }
  final userId = ref.read(firebaseAuthRepositoryProvider).loggedInUserId;
  if (userId == null) {
    return Stream.value(null);
  }
  return ref
      .read(documentRepositoryProvider)
      .snapshots(Counter.docPath(userId))
      .map((event) {
    final data = event.data();
    return data != null ? Counter.fromJson(data) : null;
  });
});

/// 保存
final saveFirestoreCounterProvider = Provider(SaveFirestoreCounter.new);

class SaveFirestoreCounter {
  SaveFirestoreCounter(this._ref);
  final Ref<SaveFirestoreCounter> _ref;

  Future<void> call(Counter counter) async {
    final userId = _ref.read(firebaseAuthRepositoryProvider).loggedInUserId;
    if (userId == null) {
      throw AppException(title: 'ログインしてください');
    }
    await _ref.read(documentRepositoryProvider).save(
          Counter.docPath(userId),
          data: counter.toDoc,
        );
  }
}
