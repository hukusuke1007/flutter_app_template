import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../../exceptions/app_exception.dart';
import '../../../../../extensions/exception_extension.dart';
import '../../../../../utils/logger.dart';
import '../../../../../utils/provider.dart';
import '../../../../entities/sample/memo.dart';
import '../../../../repositories/firebase_auth/firebase_auth_repository.dart';
import '../../../../repositories/firestore/collection_paging_repository.dart';
import '../../../../repositories/firestore/document.dart';
import '../../../../repositories/firestore/document_repository.dart';
import '../../typedef.dart';

/// StateNotifier & 非同期操作の結果を同期的に扱うサンプルコード
final memoProvider = StateNotifierProvider<MemoController, List<Memo>>((ref) {
  /// ログアウト等でauthStateの状態が更新されたら発火されて新しいインスタンスを生成する
  ref.watch(authStateProvider);
  logger.info('memoProvider create');
  return MemoController(ref);
});

class MemoController extends StateNotifier<List<Memo>> {
  MemoController(
    this._ref,
  ) : super([]) {
    final userId = _firebaseAuthRepository.loggedInUserId;
    if (userId == null) {
      return;
    }
    _collectionPagingRepository = _ref.read(
      memoCollectionPagingProvider(
        CollectionParam<Memo>(
          query: Document.colRef(
            Memo.collectionPath(userId),
          ).orderBy('createdAt', descending: true),
          initialLimit:
              state.length > defaultLimit ? state.length + 1 : defaultLimit,
          pagingLimit: defaultLimit,
          decode: Memo.fromJson,
        ),
      ),
    );
  }

  final Ref _ref;

  static int get defaultLimit => 20;

  FirebaseAuthRepository get _firebaseAuthRepository =>
      _ref.read(firebaseAuthRepositoryProvider);

  DocumentRepository get _documentRepository =>
      _ref.read(documentRepositoryProvider);

  CollectionPagingRepository<Memo>? _collectionPagingRepository;

  /// 一覧取得
  Future<ErrorMessage?> onFetch() async {
    try {
      final repository = _collectionPagingRepository;
      if (repository == null) {
        throw AppException.irregular();
      }
      final data = await repository.fetch(
        fromCache: (cache) {
          /// キャッシュから即時反映する
          state = cache.map((e) => e.entity).whereType<Memo>().toList();
        },
      );
      state = data.map((e) => e.entity).whereType<Memo>().toList();
      return null;
    } on Exception catch (e) {
      logger.shout(e);
      return e.errorMessage;
    }
  }

  /// ページング取得
  Future<ErrorMessage?> onFetchMore() async {
    try {
      final repository = _collectionPagingRepository;
      if (repository == null) {
        throw AppException.irregular();
      }

      final data = await repository.fetchMore();
      if (data.isNotEmpty) {
        state = [
          ...state,
          ...data.map((e) => e.entity).whereType<Memo>(),
        ];
      }
      return null;
    } on Exception catch (e) {
      logger.shout(e);
      return e.errorMessage;
    }
  }

  /// 作成
  Future<ErrorMessage?> onCreate(String text) async {
    try {
      final userId = _firebaseAuthRepository.loggedInUserId;
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
      await _documentRepository.save(
        Memo.docPath(userId, docRef.id),
        data: data.toCreateDoc,
      );
      state = [data, ...state];

      return null;
    } on Exception catch (e) {
      logger.shout(e);
      return e.errorMessage;
    }
  }

  /// 更新
  Future<ErrorMessage?> onUpdate(Memo memo) async {
    try {
      final userId = _firebaseAuthRepository.loggedInUserId;
      if (userId == null) {
        throw AppException(title: 'ログインしてください');
      }

      final docId = memo.memoId;
      if (docId == null) {
        throw AppException.irregular();
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

      return null;
    } on Exception catch (e) {
      logger.shout(e);
      return e.errorMessage;
    }
  }

  /// 削除
  Future<ErrorMessage?> onRemove(String docId) async {
    try {
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

      return null;
    } on Exception catch (e) {
      logger.shout(e);
      return e.errorMessage;
    }
  }
}
