import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../model/entities/sample/timeline/post.dart';
import '../../../entities/sample/enum/operation_type.dart';
import '../../../repositories/firestore/collection_paging_repository.dart';
import '../../../repositories/firestore/document.dart';
import 'fetch_timeline_post_count.dart';
import 'post/post_operation_observer.dart';

/// タイムラインを取得
final fetchTimelineAsyncProvider =
    AsyncNotifierProvider.autoDispose<FetchTimeline, List<Post>>(
  FetchTimeline.new,
);

class FetchTimeline extends AutoDisposeAsyncNotifier<List<Post>> {
  late final CollectionPagingRepository<Post> _collectionPagingRepository;

  late final StreamSubscription<OperationData> _observerDisposer;

  @override
  FutureOr<List<Post>> build() async {
    /// 自身が投稿した情報を監視してstateに反映する
    _observerDisposer = ref.read(postOperationObserverProvider).listen((value) {
      final list = state.value ?? [];
      final target = value.post;
      if (value.type == OperationType.create) {
        /// 追加する
        state = AsyncData(
          [
            target,
            ...list,
          ],
        );

        /// 投稿数を取得するProviderを再ビルドする
        ref.invalidate(fetchTimelinePostCountFutureProvider);
      } else if (value.type == OperationType.update) {
        /// 更新する
        state = AsyncData(
          list
              .map(
                (element) => element.postId == target.postId ? target : element,
              )
              .toList(
                growable: false,
              ),
        );
      } else if (value.type == OperationType.delete) {
        /// 削除する
        state = AsyncData(
          list.where((element) => element.postId != target.postId).toList(
                growable: false,
              ),
        );

        /// 投稿数を取得するProviderを再ビルドする
        ref.invalidate(fetchTimelinePostCountFutureProvider);
      }
    });

    /// 破棄されたらobserverも破棄する
    ref.onDispose(() async {
      await _observerDisposer.cancel();
    });

    /// クエリを設定したRepositoryを設定
    _collectionPagingRepository = ref.read(
      postCollectionPagingProvider(
        CollectionParam<Post>(
          query: Document.colGroupQuery(
            Post.collectionName,
          ).orderBy('createdAt', descending: true), // インデックス設定する必要がある
          limit: 20,
          decode: Post.fromJson,
        ),
      ),
    );

    /// 投稿一覧を取得する
    final data = await _collectionPagingRepository.fetch(
      fromCache: (cache) async {
        /// キャッシュから取得して即時反映
        if (cache.isNotEmpty) {
          state = AsyncData(
            cache.map((e) => e.entity).whereType<Post>().toList(
                  growable: false,
                ),
          );
        }
      },
    );

    return data.map((e) => e.entity).whereType<Post>().toList(growable: false);
  }

  /// 取得
  Future<void> onFetch() async {
    final data = await _collectionPagingRepository.fetch();
    state = AsyncData(
      data.map((e) => e.entity).whereType<Post>().toList(
            growable: false,
          ),
    );
  }

  /// 次ページの一覧を取得する
  Future<void> onFetchMore() async {
    final data = await _collectionPagingRepository.fetchMore();
    final list = state.value ?? [];
    state = AsyncData(
      [
        ...list,
        ...data.map((e) => e.entity).whereType<Post>(),
      ],
    );
  }
}
