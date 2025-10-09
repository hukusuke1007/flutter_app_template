import 'dart:async';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/exceptions/app_exception.dart';
import '../../../core/extensions/exception_extension.dart';
import '../../../core/utils/logger.dart';
import '../entities/user.dart';
import 'github_api_client.dart';

part 'github_api_repository.g.dart';

@Riverpod(keepAlive: true)
GithubApiRepository githubApiRepository(Ref ref) {
  return GithubApiRepository(ref);
}

class GithubApiRepository {
  GithubApiRepository(Ref ref) : _client = ref.read(githubApiClientProvider);

  final GithubApiClient _client;

  Future<List<User>> fetchUsers({int? since, int? perPage}) async {
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
