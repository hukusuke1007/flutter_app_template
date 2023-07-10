import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_app_template/exceptions/app_exception.dart';
import 'package:flutter_app_template/model/repositories/github_api/constants.dart';
import 'package:flutter_app_template/model/repositories/github_api/github_api_client.dart';
import 'package:flutter_app_template/model/repositories/github_api/github_api_repository.dart';
import 'package:flutter_app_template/utils/logger.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../utils.dart';
import 'github_api_repository_test.mocks.dart';

/// Unit tests
/// https://docs.flutter.dev/testing#unit-tests
/// https://docs.flutter.dev/cookbook/testing/unit/mocking
@GenerateNiceMocks([MockSpec<Dio>()])
void main() {
  /// テストで利用する定数を定義
  const baseUrl = 'https://api.github.com';

  /// 準備（テスト実施前に1回呼ばれる）
  setUpAll(Logger.configure);

  /// 正常系テストケース
  group('[正常系] GithubApiRepositoryオフラインテスト', () {
    late final MockDio dio;
    late final GithubApiClient client;

    /// 準備（テスト実施前に1回呼ばれる）
    setUpAll(() {
      dio = MockDio();
      client = GithubApiClient(dio, baseUrl: baseUrl);
    });

    test(
      'ユーザーリスト取得APIのレスポンス結果が正しいこと',
      () async {
        /// Mockにデータをセットする
        when(dio.options).thenReturn(dioDefaultOptions);
        when(dio.fetch<List<dynamic>>(any)).thenAnswer(
          (_) async => Response(
            data: json.decode(_userListData) as List<dynamic>,
            requestOptions: RequestOptions(path: '/users'),
          ),
        );

        /// MockをProviderにセットする
        final container = createContainer(
          overrides: [githubApiClientProvider.overrideWith((ref) => client)],
        );

        /// テスト実施して結果を取得
        final result = await container
            .read(githubApiRepositoryProvider)
            .fetchUsers(since: 0, perPage: 20);

        /// テスト結果を検証
        expect(result.length, 2); // 実施結果と期待値が一致していること
        verify(dio.fetch<Map<String, dynamic>>(any))
            .called(1); // 注入したMockの関数が1回呼ばれていること
      },
    );
  });

  /// 異常系テストケース
  group('[異常系] GithubApiRepositoryオフラインテスト', () {
    late final MockDio dio;
    late final GithubApiClient client;

    /// 準備（テスト実施前に1回呼ばれる）
    setUpAll(() {
      dio = MockDio();
      client = GithubApiClient(dio, baseUrl: baseUrl);
    });

    test(
      'ユーザーリスト取得APIでエラーが発生した場合、AppExceptionが発生すること',
      () async {
        /// Mockにデータをセットする
        when(dio.options).thenReturn(dioDefaultOptions);
        final requestOption = RequestOptions(path: '/users');
        when(dio.fetch<List<dynamic>>(any)).thenThrow(
          DioException(
            requestOptions: requestOption,
            response: Response(
              statusCode: 400,
              requestOptions: requestOption,
            ),
            message: 'error',
          ),
        );

        /// MockをProviderにセットする
        final container = createContainer(
          overrides: [githubApiClientProvider.overrideWith((ref) => client)],
        );

        /// テスト実施して結果を取得
        try {
          await container
              .read(githubApiRepositoryProvider)
              .fetchUsers(since: 0, perPage: 20);
          fail('failed');
        } on AppException catch (e) {
          /// テスト結果を検証
          expect(e.title, 'error'); // エラーメッセージが期待値であること
          verify(dio.fetch<Map<String, dynamic>>(any))
              .called(1); // 注入したMockの関数が1回呼ばれていること
        } on Exception catch (_) {
          fail('failed');
        }
      },
    );
  });
}

/// ダミーデータ（jsonをStringで管理）
const _userListData = '''
[
  {
    "login": "mojombo", 
    "id": 1,
    "avatar_url": "https://avatars.githubusercontent.com/u/1?v=4", 
    "url": "https://api.github.com/users/mojombo"
  },
  {
    "login": "hukusuke1007", 
    "id": 2,
    "avatar_url": "https://avatars.githubusercontent.com/u/1?v=4", 
    "url": "https://api.github.com/users/hukusuke1007"
  }
]
''';
