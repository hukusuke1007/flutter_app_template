import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/exceptions/app_exception.dart';
import '../../../core/repositories/firebase_auth/firebase_auth_repository.dart';
import '../../../core/repositories/firestore/collection_paging_repository.dart';
import '../../../core/repositories/firestore/document.dart';
import '../../../core/repositories/firestore/document_repository.dart';
import '../../../core/use_cases/authentication/auth_state_controller.dart';
import '../entities/memo.dart';

part 'memo_controller.g.dart';

@riverpod
CollectionPagingRepository<Memo> collectionPagingRepository(
  Ref ref,
  CollectionParam<Memo> query,
) {
  return CollectionPagingRepository<Memo>(
    query: query.query,
    initialLimit: query.initialLimit,
    pagingLimit: query.pagingLimit,
    decode: query.decode,
  );
}

@riverpod
class MemoController extends _$MemoController {
  static int get defaultLimit => 20;

  CollectionPagingRepository<Memo>? _collectionPagingRepository;

  @override
  Future<List<Memo>> build() async {
    /// ログアウト等でauthStateの状態が更新されたら発火されて新しいインスタンスを生成する
    ref.watch(authStateControllerProvider);

    final userId = ref.watch(firebaseAuthRepositoryProvider).loggedInUserId;
    if (userId == null) {
      return [];
    }

    final length = state.value?.length ?? 0;
    final repository = ref.watch(
      collectionPagingRepositoryProvider(
        CollectionParam<Memo>(
          query: Document.colRef(
            Memo.collectionPath(userId),
          ).orderBy('createdAt', descending: true),
          initialLimit: length > defaultLimit ? length + 1 : defaultLimit,
          pagingLimit: defaultLimit,
          decode: Memo.fromJson,
        ),
      ),
    );
    _collectionPagingRepository = repository;

    final data = await repository.fetch(
      fromCache: (cache) {
        /// キャッシュから即時反映する
        state = AsyncData(
          cache.map((e) => e.entity).whereType<Memo>().toList(),
        );
      },
    );
    return data.map((e) => e.entity).whereType<Memo>().toList();
  }

  /// ページング取得
  Future<void> onFetchMore() async {
    final repository = _collectionPagingRepository;
    if (repository == null) {
      throw AppException.irregular();
    }

    final data = await repository.fetchMore();
    final previousState = await future;
    if (data.isNotEmpty) {
      state = AsyncData([
        ...previousState,
        ...data.map((e) => e.entity).whereType<Memo>(),
      ]);
    }
  }

  /// 作成
  Future<void> onCreate(String text) async {
    final userId = ref.read(firebaseAuthRepositoryProvider).loggedInUserId;
    if (userId == null) {
      throw AppException(title: 'ログインしてください');
    }

    final docRef = Document.docRef(Memo.collectionPath(userId));
    final now = DateTime.now();
    final data = Memo(
      memoId: docRef.id,
      text: text,
      createdAt: now,
      updatedAt: now,
    );
    await ref
        .read(documentRepositoryProvider)
        .save(Memo.docPath(userId, docRef.id), data: data.toCreateDoc);
    final previousState = await future;
    state = AsyncData([data, ...previousState]);
  }

  /// 更新
  Future<void> onUpdate(Memo memo) async {
    final userId = ref.read(firebaseAuthRepositoryProvider).loggedInUserId;
    if (userId == null) {
      throw AppException(title: 'ログインしてください');
    }
    final value = await future;
    if (value.isEmpty) {
      throw AppException(title: '更新できません');
    }
    final docId = memo.memoId;
    if (docId == null) {
      throw AppException.irregular();
    }
    final data = memo.copyWith(updatedAt: DateTime.now());
    await ref
        .read(documentRepositoryProvider)
        .update(Memo.docPath(userId, docId), data: data.toUpdateDoc);
    state = AsyncData(
      value.map((e) => e.memoId == memo.memoId ? memo : e).toList(),
    );
  }

  /// 削除
  Future<void> onRemove(String docId) async {
    final userId = ref.read(firebaseAuthRepositoryProvider).loggedInUserId;
    if (userId == null) {
      throw AppException(title: 'ログインしてください');
    }
    final value = await future;
    if (value.isEmpty) {
      throw AppException(title: '削除できません');
    }
    await ref
        .read(documentRepositoryProvider)
        .remove(Memo.docPath(userId, docId));
    state = AsyncData(value.where((e) => e.memoId != docId).toList());
  }
}
