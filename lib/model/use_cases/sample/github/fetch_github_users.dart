import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../exceptions/app_exception.dart';
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
    try {
      final data = await _read(githubApiRepositoryProvider).fetchUsers(
        since: lastUserId,
        perPage: 20,
      );
      return ResultData<List<User>>.success(data);
    } on AppException catch (e) {
      return ResultData.failure(e);
    }
  }
}
