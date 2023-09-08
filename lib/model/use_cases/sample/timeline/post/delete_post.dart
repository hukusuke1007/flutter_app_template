import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../entities/sample/developer.dart';
import '../../../../entities/sample/timeline/post.dart';
import '../../../../repositories/firebase_auth/firebase_auth_repository.dart';
import '../../../../repositories/firestore/document_repository.dart';
import '../fetch_timeline.dart';
import '../fetch_timeline_post_count.dart';

part 'delete_post.g.dart';

@Riverpod(keepAlive: true)
DeletePost deletePost(DeletePostRef ref) {
  return DeletePost(ref);
}

class DeletePost {
  DeletePost(this._ref);
  final DeletePostRef _ref;

  Future<void> call(Post post) async {
    /// 自身のユーザIDを取得
    final userId = _ref.read(firebaseAuthRepositoryProvider).loggedInUserId;
    if (userId == null) {
      return;
    }

    /// 削除する投稿ID
    final postId = post.postId;

    /// サーバーへ保存する
    await _ref.read(documentRepositoryProvider).remove(
          Developer.postDocPath(
            userId: userId,
            docId: postId,
          ),
        );

    /// 削除したことを反映
    _ref
      ..invalidate(fetchTimelineProvider)
      ..invalidate(fetchTimelinePostCountProvider);
  }
}
