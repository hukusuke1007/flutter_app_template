import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../entities/sample/github/user.dart';
import '../../../repositories/github_api/github_api_repository.dart';

/// GithubのユーザーリストをAsyncNotifierで管理する
final githubUsersControllerProvider =
    AutoDisposeAsyncNotifierProvider<GithubUsersController, List<User>>(
  GithubUsersController.new,
);

class GithubUsersController extends AutoDisposeAsyncNotifier<List<User>> {
  static int get _pageCount => 20;

  int _lastUserId = 0;

  /// インスタンス生成時に取得
  @override
  FutureOr<List<User>> build() async {
    final length = state.asData?.value.length ?? 0;
    final data = await ref.watch(githubApiRepositoryProvider).fetchUsers(
          since: 0,

          /// invalidate時に取得済みのリスト個数分をperPageに設定して取得する
          perPage: length > _pageCount ? length : _pageCount,
        );
    if (data.isNotEmpty) {
      _lastUserId = data.last.id;
    } else {
      _lastUserId = 0;
    }
    return data;
  }

  /// ページング取得（リストの最下部到達時に使用する）
  Future<void> onFetchMore() async {
    final result = await AsyncValue.guard(() async {
      final data = await ref.read(githubApiRepositoryProvider).fetchUsers(
            since: _lastUserId,
            perPage: _pageCount,
          );
      if (data.isNotEmpty) {
        _lastUserId = data.last.id;
      }
      final value = state.asData?.value ?? [];
      return [...value, ...data];
    });

    state = result;
  }
}
