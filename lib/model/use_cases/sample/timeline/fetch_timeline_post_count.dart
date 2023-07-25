import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../model/repositories/firestore/collection_repository.dart';
import '../../../entities/sample/timeline/post.dart';

/// タイムラインの投稿数を取得
final fetchTimelinePostCountProvider = FutureProvider.autoDispose(
  (ref) async {
    final query = ref
        .watch(collectionRepositoryProvider)
        .group(Post.collectionName)
        .count();
    final snap = await query.get();
    return snap.count;
  },
);
