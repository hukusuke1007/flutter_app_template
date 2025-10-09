import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/entities/post/post.dart';
import '../../../core/repositories/firestore/collection_paging_repository.dart';
import '../../../core/repositories/firestore/document.dart';

part 'fetch_timeline.g.dart';

@riverpod
CollectionPagingRepository<Post> collectionPagingRepository(
  Ref ref,
  CollectionParam<Post> query,
) {
  return CollectionPagingRepository<Post>(
    query: query.query,
    initialLimit: query.initialLimit,
    pagingLimit: query.pagingLimit,
    decode: query.decode,
  );
}

/// タイムラインを取得
@riverpod
class FetchTimeline extends _$FetchTimeline {
  static int get defaultLimit => 20;

  CollectionPagingRepository<Post>? _collectionPagingRepository;

  @override
  Future<List<Post>> build() async {
    final length = state.value?.length ?? 0;

    /// クエリを設定したRepositoryを生成
    final query = Document.colGroupQuery(
      Post.collectionName,
    ).orderBy('createdAt', descending: true);
    final repository = ref.watch(
      collectionPagingRepositoryProvider(
        CollectionParam<Post>(
          query: query, // インデックス設定する必要がある
          /// invalidate後は、FetchTimelineが保持していた状態（state）はキャッシュされている。
          /// そのためinvalidate前に保持されていた個数分取得するようlimitを設定する。
          /// length に対して + 1 にしているのは、新しいデータが作成された際に個数が1つ増えることを考慮したため
          initialLimit: length > defaultLimit ? length + 1 : defaultLimit,
          pagingLimit: defaultLimit,
          decode: Post.fromJson,
        ),
      ),
    );
    _collectionPagingRepository = repository;

    /// 投稿一覧を取得する
    final data = await repository.fetch(
      fromCache: (cache) {
        /// キャッシュから取得して即時反映
        if (cache.isNotEmpty) {
          state = AsyncData(
            cache
                .map((e) => e.entity)
                .whereType<Post>()
                .toList(growable: false),
          );
        }
      },
    );

    return data.map((e) => e.entity).whereType<Post>().toList(growable: false);
  }

  /// 次ページの一覧を取得する
  Future<void> onFetchMore() async {
    final repository = _collectionPagingRepository;
    if (repository == null) {
      return;
    }
    final data = await repository.fetchMore();
    final list = await future;
    state = AsyncData([
      ...list,
      ...data.map((e) => e.entity).whereType<Post>(),
    ]);
  }
}
