import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:retrofit/retrofit.dart';

import '../../entities/sample/github/user.dart';
import 'auth_header_interceptor.dart';
import 'constants.dart';

part 'github_api_client.g.dart';

final githubApiClientProvider = Provider((ref) {
  return GithubApiClient(
    Dio(dioDefaultOptions)
      ..interceptors.addAll(
        [
          LogInterceptor(requestBody: true, responseBody: true),
          authHeaderInterceptor,
        ],
      ),
    baseUrl: 'https://api.github.com',
  );
});

@RestApi()
abstract class GithubApiClient {
  factory GithubApiClient(
    Dio dio, {
    String baseUrl,
  }) = _GithubApiClient;

  /// https://docs.github.com/ja/rest/users/users#list-users
  @GET('/users')
  Future<List<User>> fetchUsers(
    @Query('since') int? since,
    @Query('per_page') int? perPage,
  );
}
