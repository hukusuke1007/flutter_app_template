import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../model/repositories/firestore/collection_repository.dart';
import '../../../entities/sample/timeline/post.dart';

/// タイムラインの投稿数を取得
final fetchTimelinePostCountFutureProvider = FutureProvider.autoDispose(
  (ref) async {
    final query = ref
        .read(collectionRepositoryProvider)
        .group(Post.collectionName)
        .count();
    final snap = await query.get();
    return snap.count;
  },
);
