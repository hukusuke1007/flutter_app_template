import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_app_template/model/entities/sample/timeline/post.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
    // TODO(shohei): 未実装
    return null;
  }
}
