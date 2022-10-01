import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../exceptions/app_exception.dart';
import '../../../extensions/exception_extension.dart';
import '../../../results/result_void_data.dart';
import '../../../utils/logger.dart';
import '../../../utils/provider.dart';
import '../../entities/sample/memo.dart';
import '../../repositories/firebase_auth/firebase_auth_repository.dart';
import '../../repositories/firestore/collection_paging_repository.dart';
import '../../repositories/firestore/document.dart';
import '../../repositories/firestore/document_repository.dart';

final memoProvider = StateNotifierProvider<MemoController, List<Memo>>((ref) {
  ref.watch(authStateProvider);
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
      memoPagingProvider(
        CollectionParam<Memo>(
          query: Document.colRef(
            Memo.collectionPath(userId),
          ).orderBy('createdAt', descending: true),
          limit: 20,
          decode: Memo.fromJson,
        ),
      ),
    );
  }

  final Ref _ref;

  FirebaseAuthRepository get _firebaseAuthRepository =>
      _ref.read(firebaseAuthRepositoryProvider);

  DocumentRepository get _documentRepository =>
      _ref.read(documentRepositoryProvider);

  CollectionPagingRepository<Memo>? _collectionPagingRepository;

  /// 一覧取得（ResultVoidDataサンプル）
  /// ※状態はstateで管理するので関数の戻り値では返さない
  Future<ResultVoidData> fetch() async {
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
      return const ResultVoidData.success();
    } on AppException catch (e) {
      logger.shout(e);
      return ResultVoidData.failure(e);
    } on Exception catch (e) {
      logger.shout(e);
      return ResultVoidData.failure(AppException.error(e.errorMessage));
    }
  }

  /// ページング取得
  /// ※状態はstateで管理するので関数の戻り値では返さない
  Future<ResultVoidData> fetchMore() async {
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
      return const ResultVoidData.success();
    } on AppException catch (e) {
      logger.shout(e);
      return ResultVoidData.failure(e);
    } on Exception catch (e) {
      logger.shout(e);
      return ResultVoidData.failure(AppException.error(e.errorMessage));
    }
  }

  /// 作成
  Future<ResultVoidData> create(String text) async {
    try {
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
      return const ResultVoidData.success();
    } on AppException catch (e) {
      logger.shout(e);
      return ResultVoidData.failure(e);
    } on Exception catch (e) {
      logger.shout(e);
      return ResultVoidData.failure(AppException.error(e.errorMessage));
    }
  }

  /// 更新
  Future<ResultVoidData> update(Memo memo) async {
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
      return const ResultVoidData.success();
    } on AppException catch (e) {
      logger.shout(e);
      return ResultVoidData.failure(e);
    } on Exception catch (e) {
      logger.shout(e);
      return ResultVoidData.failure(AppException.error(e.errorMessage));
    }
  }

  /// 削除
  Future<ResultVoidData> remove(String docId) async {
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
      return const ResultVoidData.success();
    } on AppException catch (e) {
      logger.shout(e);
      return ResultVoidData.failure(e);
    } on Exception catch (e) {
      logger.shout(e);
      return ResultVoidData.failure(AppException.error(e.errorMessage));
    }
  }
}
