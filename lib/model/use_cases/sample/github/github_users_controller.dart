import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../entities/sample/github/user.dart';
import '../../../repositories/api/github_api/github_api_repository.dart';

/// GithubのユーザーリストをAsyncNotifierで管理する
final githubUsersControllerProvider =
    AutoDisposeAsyncNotifierProvider<GithubUsersController, List<User>>(
  GithubUsersController.new,
);

class GithubUsersController extends AutoDisposeAsyncNotifier<List<User>> {
  /// 重複読み込み防止フラグ
  bool _loading = false;

  /// クエリパラメータ
  int _lastUserId = 0;
  final _pageCount = 20;

  GithubApiRepository get _githubApiRepository =>
      ref.read(githubApiRepositoryProvider);

  /// インスタンス生成時に初回読み込み
  @override
  FutureOr<List<User>> build() async {
    final data = await _githubApiRepository.fetchUsers(
      since: 0,
      perPage: _pageCount,
    );
    if (data.isNotEmpty) {
      _lastUserId = data.last.id;
    }
    return data;
  }

  /// 取得（PullToRefresh時に使用する）
  Future<void> fetch() async {
    if (_loading) {
      return;
    }
    _loading = true;

    _lastUserId = 0;

    final result = await AsyncValue.guard(() async {
      final data = await _githubApiRepository.fetchUsers(
        since: _lastUserId,
        perPage: _pageCount,
      );
      if (data.isNotEmpty) {
        _lastUserId = data.last.id;
      }
      return data;
    });

    _loading = false;
    state = result;
  }

  /// ページング取得（リストの最下部到達時に使用する）
  Future<void> fetchMore() async {
    if (_loading) {
      return;
    }
    _loading = true;

    final result = await AsyncValue.guard(() async {
      final data = await _githubApiRepository.fetchUsers(
        since: _lastUserId,
        perPage: _pageCount,
      );
      if (data.isNotEmpty) {
        _lastUserId = data.last.id;
      }
      final value = state.asData?.value ?? [];
      return [...value, ...data];
    });

    _loading = false;
    state = result;
  }
}
