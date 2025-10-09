import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../entities/github/user.dart';
import '../../repositories/github_api/github_api_repository.dart';

part 'github_users_controller.g.dart';

/// GithubのユーザーリストをAsyncNotifierで管理する
@riverpod
class GithubUsersController extends _$GithubUsersController {
  static int get _pageCount => 20;

  var _lastUserId = 0;

  /// インスタンス生成時に取得
  @override
  Future<List<User>> build() async {
    final length = state.asData?.value.length ?? 0;
    final data = await ref
        .watch(githubApiRepositoryProvider)
        .fetchUsers(
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
      final data = await ref
          .read(githubApiRepositoryProvider)
          .fetchUsers(since: _lastUserId, perPage: _pageCount);
      if (data.isNotEmpty) {
        _lastUserId = data.last.id;
      }
      final previousState = await future;
      return [...previousState, ...data];
    });

    state = result;
  }
}
