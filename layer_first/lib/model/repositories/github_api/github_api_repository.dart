import 'dart:async';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../exceptions/app_exception.dart';
import '../../../extensions/exception_extension.dart';
import '../../entities/github/user.dart';
import 'github_api_client.dart';

part 'github_api_repository.g.dart';

@Riverpod(keepAlive: true)
GithubApiRepository githubApiRepository(Ref ref) {
  return GithubApiRepository(ref);
}

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
      throw AppException.error(e.message ?? 'error');
    } on Exception catch (e) {
      throw AppException.error(e.errorMessage);
    }
  }
}
