import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../model/entities/sample/developer.dart';
import '../../../../utils/logger.dart';
import '../../../../utils/provider.dart';
import '../../../repositories/firestore/document_repository.dart';

/// 投稿者を取得（スナップショットリスナー使用）
final fetchPosterStreamProvider =
    StreamProvider.autoDispose.family<Developer?, String>((ref, userId) {
  final authState = ref.watch(authStateProvider);
  if (authState == AuthState.noSignIn) {
    return Stream.value(null);
  }

  return ref
      .read(documentRepositoryProvider)
      .snapshots(Developer.docPath(userId))
      .map((event) {
    /// スナップショットリスナーを使うことで2回発火する
    /// 初回はキャッシュから取得、2回目はサーバーから取得
    /// 初回はキャッシュから取得できるので反映が速い
    logger.info('userId: $userId, isFromCache: ${event.metadata.isFromCache}');
    final data = event.data();
    return data != null ? Developer.fromJson(data) : null;
  });
});
