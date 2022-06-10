import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../exceptions/app_exception.dart';
import '../../../../extensions/exception_extension.dart';
import '../../../../results/result_data.dart';
import '../../../../utils/logger.dart';
import '../../../entities/sample/github/user.dart';
import '../../../repositories/api/github_api/github_api_repository.dart';

final githubUsersControllerProvider =
    StateNotifierProvider<GithubUsersController, List<User>>((ref) {
  return GithubUsersController(ref.read);
});

class GithubUsersController extends StateNotifier<List<User>> {
  GithubUsersController(
    this._read,
  ) : super([]);

  final Reader _read;

  int _pageOffset = 0;

  GithubApiRepository get _githubApiRepository =>
      _read(githubApiRepositoryProvider);

  /// 一覧取得
  Future<ResultData<List<User>>> fetch() async {
    try {
      _pageOffset = 0;
      final data = await _githubApiRepository.fetchUsers(
        since: _pageOffset,
      );
      if (data.isNotEmpty) {
        _pageOffset = data.length;
      }
      state = data;
      return ResultData.success(data);
    } on AppException catch (e) {
      logger.shout(e);
      return ResultData.failure(e);
    } on Exception catch (e) {
      logger.shout(e);
      return ResultData.failure(AppException.error(e.errorMessage));
    }
  }

  /// ページング取得
  Future<ResultData<List<User>>> fetchMore() async {
    try {
      final data = await _githubApiRepository.fetchUsers(
        since: _pageOffset,
      );
      if (data.isNotEmpty) {
        _pageOffset += data.length;
      }
      state = [...state, ...data];
      return ResultData.success(data);
    } on AppException catch (e) {
      logger.shout(e);
      return ResultData.failure(e);
    } on Exception catch (e) {
      logger.shout(e);
      return ResultData.failure(AppException.error(e.errorMessage));
    }
  }
}
