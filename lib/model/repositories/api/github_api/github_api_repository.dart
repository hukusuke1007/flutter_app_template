import 'dart:async';

import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../exceptions/app_exception.dart';
import '../../../entities/sample/github/user.dart';
import 'github_api_client.dart';

final githubApiRepositoryProvider = Provider<GithubApiRepository>((ref) {
  return GithubApiRepository(ref.read);
});

class GithubApiRepository {
  GithubApiRepository(
    Reader read,
  ) {
    _client = read(githubApiClientProvider);
  }

  late final GithubApiClient _client;

  Future<List<User>> fetchUsers({
    int? since,
    int? perPage,
  }) async {
    try {
      return _client.fetchUsers(since, perPage);
    } on DioError catch (e) {
      throw AppException.error(e.message);
    }
  }
}
