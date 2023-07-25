import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../model/entities/sample/timeline/post.dart';
import '../../../repositories/firestore/collection_paging_repository.dart';
import '../../../repositories/firestore/document.dart';

/// タイムラインを取得
final fetchTimelineProvider =
    AsyncNotifierProvider.autoDispose<FetchTimeline, List<Post>>(
  FetchTimeline.new,
);

class FetchTimeline extends AutoDisposeAsyncNotifier<List<Post>> {
  static int get defaultLimit => 20;

  CollectionPagingRepository<Post>? _collectionPagingRepository;

  @override
  FutureOr<List<Post>> build() async {
    final length = state.asData?.value.length ?? 0;

    /// クエリを設定したRepositoryを生成
    final query = Document.colGroupQuery(
      Post.collectionName,
    ).orderBy('createdAt', descending: true);
    final repository = ref.watch(
      postCollectionPagingProvider(
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

  /// 次ページの一覧を取得する
  Future<void> onFetchMore() async {
    final repository = _collectionPagingRepository;
    if (repository == null) {
      return;
    }
    final data = await repository.fetchMore();
    final list = state.value ?? [];
    state = AsyncData(
      [
        ...list,
        ...data.map((e) => e.entity).whereType<Post>(),
      ],
    );
  }
}
