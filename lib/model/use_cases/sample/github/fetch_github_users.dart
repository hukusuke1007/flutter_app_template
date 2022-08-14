import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../results/result_data.dart';
import '../../../entities/sample/github/user.dart';
import '../../../repositories/api/github_api/github_api_repository.dart';

/// Githubのユーザーリストを取得するProvider
/// 状態の保持は利用者（Page側）に委ねる
final fetchGithubUsersProvider =
    Provider<FetchGithubUsers>((ref) => FetchGithubUsers(ref.read));

class FetchGithubUsers {
  const FetchGithubUsers(this._read);

  final Reader _read;

  Future<ResultData<List<User>>> call({
    int? lastUserId,
  }) async {
    final data = await ResultData.guard(
      () => _read(githubApiRepositoryProvider).fetchUsers(
        since: lastUserId,
        perPage: 20,
      ),
    );
    return data;
  }
}
