import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../model/entities/sample/developer.dart';
import '../../../../utils/logger.dart';
import '../../../repositories/firestore/document_repository.dart';
import '../auth/auth_state_controller.dart';

part 'fetch_poster.g.dart';

/// 投稿者を取得
@riverpod
class FetchPoster extends _$FetchPoster {
  @override
  Future<Developer?> build(String userId) async {
    /// キャッシュから取得して即時反映
    final cache = await ref.watch(documentRepositoryProvider).fetchCacheOnly(
          Developer.docPath(userId),
          decode: Developer.fromJson,
        );
    if (cache.exists) {
      state = AsyncData(cache.entity);
    }

    /// サーバーから取得して最新情報を反映
    final data = await ref.watch(documentRepositoryProvider).fetch(
          Developer.docPath(userId),
          decode: Developer.fromJson,
        );
    if (data.exists) {
      return data.entity;
    } else {
      return null;
    }
  }
}

/// 投稿者を取得（スナップショットリスナー使用）
@riverpod
class FetchPosterStream extends _$FetchPosterStream {
  @override
  Stream<Developer?> build(String userId) {
    final authState = ref.watch(authStateControllerProvider);
    if (authState == AuthState.noSignIn) {
      return Stream.value(null);
    }

    return ref
        .watch(documentRepositoryProvider)
        .snapshots(Developer.docPath(userId))
        .map((event) {
      /// スナップショットリスナーを使うことで2回発火する
      /// 初回はキャッシュから取得、2回目はサーバーから取得
      /// 初回はキャッシュから取得できるので反映が速い
      logger
          .info('userId: $userId, isFromCache: ${event.metadata.isFromCache}');
      final data = event.data();
      return data != null ? Developer.fromJson(data) : null;
    });
  }
}
