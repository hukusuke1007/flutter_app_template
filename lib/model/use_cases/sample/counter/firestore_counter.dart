import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../exceptions/app_exception.dart';
import '../../../../extensions/exception_extension.dart';
import '../../../../utils/logger.dart';
import '../../../../utils/provider.dart';
import '../../../entities/sample/counter.dart';
import '../../../repositories/firebase_auth/firebase_auth_repository.dart';
import '../../../repositories/firestore/document_repository.dart';

final firestoreCounterProvider =
    AsyncNotifierProvider.autoDispose<FirestoreCounter, Counter?>(
  FirestoreCounter.new,
);

class FirestoreCounter extends AutoDisposeAsyncNotifier<Counter?> {
  @override
  FutureOr<Counter?> build() async {
    ref.watch(authStateProvider);

    final userId = ref.watch(firebaseAuthRepositoryProvider).loggedInUserId;
    if (userId == null) {
      throw AppException(title: 'ログインしてください');
    }
    final doc = await ref.watch(documentRepositoryProvider).fetch<Counter>(
          Counter.docPath(userId),
          decode: Counter.fromJson,
        );
    return doc.entity;
  }

  Future<void> save(int incrementCount) async {
    try {
      if (state.isLoading) {
        return;
      }
      final userId = ref.read(firebaseAuthRepositoryProvider).loggedInUserId;
      if (userId == null) {
        throw AppException(title: 'ログインしてください');
      }
      final prevCount = state.asData?.value?.count ?? 0;
      final data = state.asData?.value?.copyWith(
            count: prevCount + incrementCount,
          ) ??
          Counter(count: incrementCount);

      await ref.read(documentRepositoryProvider).save(
            Counter.docPath(userId),
            data: data.toDoc,
          );
      state = AsyncData(data);
    } on Exception catch (e) {
      logger.shout(e);
      state = AsyncError(
        AppException(title: e.errorMessage),
        StackTrace.current,
      );
    }
  }
}
