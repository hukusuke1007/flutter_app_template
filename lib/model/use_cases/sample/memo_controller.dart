import 'package:flutter_app_template/model/exceptions/app_exception.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../entities/sample/memo.dart';
import '../../repositories/firebase_auth/firebase_auth_repository.dart';
import '../../repositories/firestore/collection_paging_repository.dart';
import '../../repositories/firestore/document.dart';
import '../../repositories/firestore/document_repository.dart';

final memoControllerProvider =
    StateNotifierProvider<MemoController, List<Memo>>((ref) {
  return MemoController(ref.read);
});

class MemoController extends StateNotifier<List<Memo>> {
  MemoController(
    this._read,
  ) : super([]) {
    final userId = _firebaseAuthRepository.loggedInUserId;
    if (userId == null) {
      throw AppException(title: 'ログインしてください');
    }
    _collectionPagingRepository = _read(memoPagingProvider(
      CollectionParam<Memo>(
        query: Document.colRef(
          Memo.collectionPath(userId),
        ).orderBy('createdAt', descending: true),
        limit: 20,
        decode: Memo.fromJson,
      ),
    ));
  }

  final Reader _read;

  FirebaseAuthRepository get _firebaseAuthRepository =>
      _read(firebaseAuthRepositoryProvider);

  DocumentRepository get _documentRepository =>
      _read(documentRepositoryProvider);

  CollectionPagingRepository<Memo>? _collectionPagingRepository;

  /// 一覧取得
  Future<void> fetch() async {
    final repository = _collectionPagingRepository;
    if (repository == null) {
      return;
    }
    final data = await repository.fetch();
    state = data.map((e) => e.entity).whereType<Memo>().toList();
  }

  /// ページング取得
  Future<void> fetchMore() async {
    final repository = _collectionPagingRepository;
    if (repository == null) {
      return;
    }
    final data = await repository.fetchMore();
    if (data.isEmpty) {
      return;
    }
    state = [
      ...state.toList(),
      ...data.map((e) => e.entity).whereType<Memo>().toList(),
    ];
  }

  /// 作成
  Future<void> create(String text) async {
    final userId = _firebaseAuthRepository.loggedInUserId;
    if (userId == null) {
      throw AppException(title: 'ログインしてください');
    }
    final ref = Document.docRef(Memo.collectionPath(userId));
    final now = DateTime.now();
    final data = Memo(
      memoId: ref.id,
      text: text,
      createdAt: now,
      updatedAt: now,
    );
    await _documentRepository.save(
      Memo.docPath(userId, ref.id),
      data: data.toCreateDoc,
    );
    state = [data, ...state];
  }

  /// 更新
  Future<void> update(Memo memo) async {
    final userId = _firebaseAuthRepository.loggedInUserId;
    if (userId == null) {
      throw AppException(title: 'ログインしてください');
    }
    final docId = memo.memoId;
    if (docId == null) {
      return;
    }
    final data = memo.copyWith(updatedAt: DateTime.now());
    await _documentRepository.update(
      Memo.docPath(userId, docId),
      data: data.toUpdateDoc,
    );
    state = state
        .map(
          (e) => e.memoId == memo.memoId ? memo : e,
        )
        .toList();
  }

  /// 削除
  Future<void> remove(String docId) async {
    final userId = _firebaseAuthRepository.loggedInUserId;
    if (userId == null) {
      throw AppException(title: 'ログインしてください');
    }
    await _documentRepository.remove(Memo.docPath(userId, docId));
    state = state
        .where(
          (e) => e.memoId != docId,
        )
        .toList();
  }
}
