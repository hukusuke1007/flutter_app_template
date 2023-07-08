import 'dart:async';

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../exceptions/app_exception.dart';
import '../../../../extensions/exception_extension.dart';
import '../../../../utils/logger.dart';
import '../../entities/sample/github/user.dart';
import 'github_api_client.dart';

final githubApiRepositoryProvider = Provider<GithubApiRepository>(
  GithubApiRepository.new,
);

class GithubApiRepository {
  GithubApiRepository(
    Ref ref,
  ) : _client = ref.read(githubApiClientProvider);

  final GithubApiClient _client;

  Future<List<User>> fetchUsers({
    int? since,
    int? perPage,
  }) async {
    try {
      final result = await _client.fetchUsers(since, perPage);
      return result;
    } on DioException catch (e) {
      final response = e.response;
      logger.shout(
        'statusCode: ${response?.statusCode}, '
        'message: ${response?.statusMessage}',
      );
      throw AppException.error(e.message ?? 'error');
    } on Exception catch (e) {
      logger.shout(e);
      throw AppException.error(e.errorMessage);
    }
  }
}
