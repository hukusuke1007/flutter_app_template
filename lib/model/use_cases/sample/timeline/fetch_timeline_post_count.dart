import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../model/repositories/firestore/collection_repository.dart';
import '../../../entities/sample/timeline/post.dart';

part 'fetch_timeline_post_count.g.dart';

/// タイムラインの投稿数を取得
@riverpod
Future<int> fetchTimelinePostCount(FetchTimelinePostCountRef ref) async {
  final query = ref
      .watch(collectionRepositoryProvider)
      .group(Post.collectionName)
      .count();
  final snap = await query.get();
  return snap.count;
}
