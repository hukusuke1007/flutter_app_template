import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../utils/provider.dart';
import '../../entities/sample/counter.dart';
import '../../exceptions/app_exception.dart';
import '../../repositories/firebase_auth/firebase_auth_repository.dart';
import '../../repositories/firestore/document_repository.dart';

/// 取得（スナップショットリスナー未使用）
final fetchFirestoreCounterProvider =
    Provider((ref) => FetchFirestoreCounter(ref.read));

class FetchFirestoreCounter {
  FetchFirestoreCounter(this._read);
  final Reader _read;

  Future<Counter?> call() async {
    final userId = _read(firebaseAuthRepositoryProvider).loggedInUserId;
    if (userId == null) {
      throw AppException(title: 'ログインしてください');
    }
    final doc = await _read(documentRepositoryProvider).fetch<Counter>(
      Counter.docPath(userId),
      decode: Counter.fromJson,
    );
    return doc.entity;
  }
}

/// 取得（スナップショットリスナー使用）
final fetchFirestoreCounterStreamProvider = StreamProvider<Counter?>((ref) {
  ref.watch(authStateProvider);
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
final saveFirestoreCounterProvider =
    Provider((ref) => SaveFirestoreCounter(ref.read));

class SaveFirestoreCounter {
  SaveFirestoreCounter(this._read);
  final Reader _read;

  Future<void> call(Counter counter) async {
    final userId = _read(firebaseAuthRepositoryProvider).loggedInUserId;
    if (userId == null) {
      throw AppException(title: 'ログインしてください');
    }
    await _read(documentRepositoryProvider).save(
      Counter.docPath(userId),
      data: counter.toDoc,
    );
  }
}
