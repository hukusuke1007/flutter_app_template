import 'dart:async';

import 'package:flutter_app_template/utils/logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../model/entities/sample/timeline/post.dart';
import '../../../repositories/firestore/collection_paging_repository.dart';
import '../../../repositories/firestore/document.dart';

/// タイムラインを取得
final fetchTimelineAsyncProvider =
    AsyncNotifierProvider.autoDispose<FetchTimeline, List<Post>>(
  FetchTimeline.new,
);

class FetchTimeline extends AutoDisposeAsyncNotifier<List<Post>> {
  static int get defaultLimit => 5;

  CollectionPagingRepository<Post>? _collectionPagingRepository;

  @override
  FutureOr<List<Post>> build() async {
    logger.info(state.asData?.value.length);

    /// クエリを設定したRepositoryを設定
    final repository = ref.read(
      postCollectionPagingProvider(
        CollectionParam<Post>(
          query: Document.colGroupQuery(
            Post.collectionName,
          ).orderBy('createdAt', descending: true), // インデックス設定する必要がある

          /// invalidate後は、FetchTimelineが保持していた状態（state）はキャッシュされている。
          /// そのためinvalidate前に保持されていた個数分取得するようlimitを設定する。
          initialLimit: state.asData?.value.length ?? defaultLimit,
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

  /// 取得
  Future<void> onFetch() async {
    final repository = _collectionPagingRepository;
    if (repository == null) {
      return;
    }
    final data = await repository.fetch();
    state = AsyncData(
      data.map((e) => e.entity).whereType<Post>().toList(
            growable: false,
          ),
    );
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
