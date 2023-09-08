import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../entities/sample/github/user.dart';
import '../../../repositories/github_api/github_api_repository.dart';

part 'fetch_github_users.g.dart';

/// Githubのユーザーリストを取得するProvider
/// 状態の保持は利用者（Page側）に委ねる
@Riverpod(keepAlive: true)
FetchGithubUsers fetchGithubUsers(FetchGithubUsersRef ref) {
  return FetchGithubUsers(ref);
}

class FetchGithubUsers {
  const FetchGithubUsers(this._ref);

  final Ref _ref;

  Future<AsyncValue<List<User>>> call({
    int? lastUserId,
  }) async {
    final data = await AsyncValue.guard(
      () => _ref.read(githubApiRepositoryProvider).fetchUsers(
            since: lastUserId,
            perPage: 20,
          ),
    );
    return data;
  }
}
