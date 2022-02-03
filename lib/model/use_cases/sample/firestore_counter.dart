import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../entities/sample/counter.dart';
import '../../exceptions/app_exception.dart';
import '../../repositories/firebase_auth/firebase_auth_repository.dart';
import '../../repositories/firestore/document_repository.dart';

final fetchFirestoreCounter =
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

final saveFirestoreCounter = Provider((ref) => SaveFirestoreCounter(ref.read));

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
      data: counter.toJson(),
    );
  }
}
