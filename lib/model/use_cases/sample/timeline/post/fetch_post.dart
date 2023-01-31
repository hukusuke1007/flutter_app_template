import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../entities/sample/developer.dart';
import '../../../../entities/sample/timeline/post.dart';
import '../../../../repositories/firestore/document_repository.dart';

@immutable
class FetchPostArgs {
  const FetchPostArgs({
    required this.postId,
    required this.userId,
  });
  final String postId;
  final String userId;
}

/// 投稿を取得
final fetchPostAsyncProviders =
    AsyncNotifierProvider.autoDispose.family<FetchPost, Post?, FetchPostArgs>(
  FetchPost.new,
);

class FetchPost extends AutoDisposeFamilyAsyncNotifier<Post?, FetchPostArgs> {
  // late final StreamSubscription<OperationData> _observerDisposer;

  @override
  FutureOr<Post?> build(FetchPostArgs arg) async {
    final userId = arg.userId;
    final docId = arg.postId;

    // /// 自身が投稿した情報を監視してstateに反映する
    // _observerDisposer = ref.read(postOperationObserverProvider).listen((value) {
    //   final target = value.post;
    //   if (value.type == OperationType.update) {
    //     /// 更新する
    //     state = AsyncData(target);
    //   }
    // });

    // /// 破棄されたらobserverも破棄する
    // ref.onDispose(() async {
    //   await _observerDisposer.cancel();
    // });

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
