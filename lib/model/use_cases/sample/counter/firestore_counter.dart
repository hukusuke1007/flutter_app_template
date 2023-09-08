import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../exceptions/app_exception.dart';
import '../../../../extensions/exception_extension.dart';
import '../../../../utils/logger.dart';
import '../../../entities/sample/counter.dart';
import '../../../repositories/firebase_auth/firebase_auth_repository.dart';
import '../../../repositories/firestore/document_repository.dart';
import '../auth/auth_state_controller.dart';

part 'firestore_counter.g.dart';

@riverpod
class FirestoreCounter extends _$FirestoreCounter {
  @override
  FutureOr<Counter?> build() async {
    ref.watch(authStateControllerProvider);

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
