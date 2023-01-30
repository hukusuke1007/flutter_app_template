import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../entities/sample/developer.dart';
import '../../../../entities/sample/timeline/post.dart';
import '../../../../repositories/firestore/document_repository.dart';

@immutable
class FetchPostParam {
  const FetchPostParam({
    required this.postId,
    required this.userId,
  });
  final String postId;
  final String userId;
}

/// 投稿を取得
final fetchPostAsyncProviders =
    AsyncNotifierProvider.autoDispose.family<FetchPost, Post?, FetchPostParam>(
  FetchPost.new,
);

class FetchPost extends AutoDisposeFamilyAsyncNotifier<Post?, FetchPostParam> {
  @override
  FutureOr<Post?> build(FetchPostParam arg) async {
    final userId = arg.userId;
    final docId = arg.postId;

    /// キャッシュから取得して即時反映
    final cache = await ref.read(documentRepositoryProvider).fetchCacheOnly(
          Developer.postDocPath(userId: userId, docId: docId),
          decode: Post.fromJson,
        );
    if (cache.exists) {
      state = AsyncData(cache.entity);
    }

    /// サーバーから取得して最新情報を反映
    final data = await ref.read(documentRepositoryProvider).fetch(
          Developer.postDocPath(userId: userId, docId: docId),
          decode: Post.fromJson,
        );
    if (data.exists) {
      return data.entity;
    } else {
      return null;
    }
  }
}
