import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/repositories/dio/auth_header_interceptor.dart';
import '../../../core/repositories/dio/constants.dart';
import '../entities/user.dart';

part 'github_api_client.g.dart';

@Riverpod(keepAlive: true)
GithubApiClient githubApiClient(Ref ref) {
  return GithubApiClient(
    Dio(dioDefaultOptions)
      ..interceptors.addAll([
        if (kDebugMode) LogInterceptor(requestBody: true, responseBody: true),
        authHeaderInterceptor,
      ]),
    baseUrl: 'https://api.github.com',
  );
}

@RestApi()
// ignore:one_member_abstracts
abstract class GithubApiClient {
  factory GithubApiClient(Dio dio, {String baseUrl}) = _GithubApiClient;

  /// https://docs.github.com/ja/rest/users/users#list-users
  @GET('/users')
  Future<List<User>> fetchUsers(
    @Query('since') int? since,
    @Query('per_page') int? perPage,
  );
}
