import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../entities/sample/github/user.dart';
import '../../../repositories/github_api/github_api_repository.dart';

/// Githubのユーザーリストを取得するProvider
/// 状態の保持は利用者（Page側）に委ねる
final fetchGithubUsersProvider =
    Provider<FetchGithubUsers>(FetchGithubUsers.new);

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
