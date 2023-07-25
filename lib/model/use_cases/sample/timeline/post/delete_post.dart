import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../entities/sample/developer.dart';
import '../../../../entities/sample/timeline/post.dart';
import '../../../../repositories/firebase_auth/firebase_auth_repository.dart';
import '../../../../repositories/firestore/document_repository.dart';
import '../fetch_timeline.dart';
import '../fetch_timeline_post_count.dart';

final deletePostProvider = Provider(DeletePost.new);

class DeletePost {
  DeletePost(this._ref);
  final Ref _ref;

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
