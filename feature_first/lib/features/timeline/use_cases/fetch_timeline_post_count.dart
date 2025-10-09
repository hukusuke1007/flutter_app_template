import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/entities/post/post.dart';
import '../../../core/repositories/firestore/collection_repository.dart';

part 'fetch_timeline_post_count.g.dart';

/// タイムラインの投稿数を取得
@riverpod
Future<int> fetchTimelinePostCount(Ref ref) async {
  final query = ref
      .watch(collectionRepositoryProvider)
      .group(Post.collectionName)
      .count();
  final snap = await query.get();
  return snap.count ?? 0;
}
