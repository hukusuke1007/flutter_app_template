import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/exceptions/app_exception.dart';
import '../../../core/repositories/firebase_auth/firebase_auth_repository.dart';
import '../../../core/repositories/firestore/document_repository.dart';
import '../../../core/use_cases/authentication/auth_state_controller.dart';
import '../entities/counter.dart';

part 'firestore_counter.g.dart';

@riverpod
class FirestoreCounter extends _$FirestoreCounter {
  @override
  Future<Counter?> build() async {
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
    if (state.isLoading) {
      return;
    }
    state = await AsyncValue.guard(() async {
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
      return data;
    });
  }
}
