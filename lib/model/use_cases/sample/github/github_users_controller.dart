import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../exceptions/app_exception.dart';
import '../../../../results/result_data.dart';
import '../../../entities/sample/github/user.dart';
import '../../../repositories/api/github_api/github_api_repository.dart';

final githubUsersControllerProvider =
    StateNotifierProvider.autoDispose<GithubUsersController, List<User>>((ref) {
  return GithubUsersController(ref.read);
});

class GithubUsersController extends StateNotifier<List<User>> {
  GithubUsersController(
    this._read,
  ) : super([]);

  final Reader _read;

  int _pageOffset = 0;
  final _pageCount = 20;

  GithubApiRepository get _githubApiRepository =>
      _read(githubApiRepositoryProvider);

  /// 一覧取得
  Future<ResultData<List<User>>> fetch() async {
    try {
      _pageOffset = 0;
      final data = await _githubApiRepository.fetchUsers(
        since: _pageOffset,
        perPage: _pageCount,
      );
      if (data.isNotEmpty) {
        _pageOffset = data.length;
      }
      state = data;
      return ResultData.success(data);
    } on AppException catch (e) {
      return ResultData.failure(e);
    }
  }

  /// ページング取得
  Future<ResultData<List<User>>> fetchMore() async {
    try {
      final data = await _githubApiRepository.fetchUsers(
        since: _pageOffset,
        perPage: _pageCount,
      );
      if (data.isNotEmpty) {
        _pageOffset += data.length;
      }
      state = [...state, ...data];
      return ResultData.success(data);
    } on AppException catch (e) {
      return ResultData.failure(e);
    }
  }
}
