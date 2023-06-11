import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../entities/sample/developer.dart';
import '../../../../entities/sample/timeline/post.dart';
import '../../../../repositories/firestore/document_repository.dart';

/// https://docs-v2.riverpod.dev/docs/concepts/modifiers/family#passing-multiple-parameters-to-a-family
class FetchPostArgs extends Equatable {
  const FetchPostArgs({
    required this.postId,
    required this.userId,
  });
  final String postId;
  final String userId;

  @override
  List<Object?> get props => [postId, userId];
}

/// 投稿を取得
final fetchPostAsyncProviders =
    AsyncNotifierProvider.autoDispose.family<FetchPost, Post?, FetchPostArgs>(
  FetchPost.new,
);

class FetchPost extends AutoDisposeFamilyAsyncNotifier<Post?, FetchPostArgs> {
  @override
  FutureOr<Post?> build(FetchPostArgs arg) async {
    final userId = arg.userId;
    final docId = arg.postId;

    /// キャッシュから取得して即時反映
    final cache = await ref.watch(documentRepositoryProvider).fetchCacheOnly(
          Developer.postDocPath(userId: userId, docId: docId),
          decode: Post.fromJson,
        );
    if (cache.exists) {
      state = AsyncData(cache.entity);
    }

    /// サーバーから取得して最新情報を反映
    final data = await ref.watch(documentRepositoryProvider).fetch(
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
