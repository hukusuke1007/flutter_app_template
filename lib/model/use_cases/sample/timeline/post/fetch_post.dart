import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../entities/sample/developer.dart';
import '../../../../entities/sample/timeline/post.dart';
import '../../../../repositories/firestore/document_repository.dart';

part 'fetch_post.g.dart';

/// 投稿を取得

@riverpod
class FetchPost extends _$FetchPost {
  @override
  FutureOr<Post?> build({
    required String posterId,
    required String postId,
  }) async {
    final docId = postId;

    /// キャッシュから取得して即時反映
    final cache = await ref.watch(documentRepositoryProvider).fetchCacheOnly(
          Developer.postDocPath(userId: posterId, docId: docId),
          decode: Post.fromJson,
        );
    if (cache.exists) {
      state = AsyncData(cache.entity);
    }

    /// サーバーから取得して最新情報を反映
    final data = await ref.watch(documentRepositoryProvider).fetch(
          Developer.postDocPath(userId: posterId, docId: docId),
          decode: Post.fromJson,
        );
    if (data.exists) {
      return data.entity;
    } else {
      return null;
    }
  }
}
