import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../model/repositories/firestore/collection_repository.dart';
import '../../../entities/sample/timeline/post.dart';

/// タイムラインの投稿数を取得
final fetchTimelinePostCountAsyncProvider =
    AsyncNotifierProvider.autoDispose<FetchTimelinePostCount, int>(
  FetchTimelinePostCount.new,
);

class FetchTimelinePostCount extends AutoDisposeAsyncNotifier<int> {
  @override
  FutureOr<int> build() async {
    final collectionRepository = ref.read(collectionRepositoryProvider);
    final query = collectionRepository.group(Post.collectionName).count();
    final snap = await query.get();
    return snap.count;
  }
}
