import 'package:flutter_app_template/exceptions/app_exception.dart';
import 'package:flutter_app_template/model/entities/sample/github/user.dart';
import 'package:flutter_app_template/model/repositories/github_api/github_api_repository.dart';
import 'package:flutter_app_template/model/use_cases/sample/github/github_users_controller.dart';
import 'package:flutter_app_template/utils/logger.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../utils.dart';
import 'github_users_controller_test.mocks.dart';

/// Unit tests
/// https://docs.flutter.dev/testing#unit-tests
/// https://docs.flutter.dev/cookbook/testing/unit/mocking
@GenerateNiceMocks(
  [MockSpec<GithubApiRepository>()],
)
void main() {
  /// 前処理（テスト前に1回呼ばれる）
  setUpAll(Logger.configure);

  /// 正常系テストケース
  group('[正常系] GithubUsersController オフラインテスト', () {
    late final MockGithubApiRepository mockGithubApiRepository;

    /// 前処理（テスト前に1回呼ばれる）
    setUpAll(() {
      mockGithubApiRepository = MockGithubApiRepository();
    });

    /// 後処理（テスト後に毎回呼ばれる）
    tearDown(() {
      reset(mockGithubApiRepository); // セットされたデータを初期化するためにモックをリセットする
    });

    test(
      'ユーザーリストを取得できること',
      () async {
        /// Mockにデータをセットする
        when(mockGithubApiRepository.fetchUsers(since: 0, perPage: 20))
            .thenAnswer((_) async {
          return List.generate(20, (index) {
            final id = index;
            return User(
              login: 'User $id',
              id: id,
              url: 'https://example/$id',
            );
          });
        });
        when(mockGithubApiRepository.fetchUsers(since: 19, perPage: 20))
            .thenAnswer((_) async {
          return List.generate(20, (index) {
            final id = index + 20;
            return User(
              login: 'User $id',
              id: id,
              url: 'https://example/$id',
            );
          });
        }); // ページング取得用にセット

        /// ProviderにMockをセットする
        final container = createContainer(
          overrides: [
            githubApiRepositoryProvider.overrideWithValue(
              mockGithubApiRepository,
            ),
          ],
        );

        /// テスト実施（初回取得）
        await container.read(
          githubUsersControllerProvider.future,
        ); // build内が処理されるまで待つ

        expect(
          container.exists(githubUsersControllerProvider),
          isTrue,
        ); // Providerのインスタンスが生成されていることを確認
        expect(
          container.read(githubUsersControllerProvider).asData?.value.length,
          20,
        ); // リスト個数が期待値であるか確認

        /// テスト実施（ページング処理）
        await container
            .read(githubUsersControllerProvider.notifier)
            .onFetchMore();
        expect(
          container.read(githubUsersControllerProvider).asData?.value.length,
          40,
        ); // リスト個数が期待値であるか確認

        verify(
          container
              .read(githubApiRepositoryProvider)
              .fetchUsers(since: 0, perPage: 20),
        ).called(1); // 注入したMockの関数が1回呼ばれていること（buildで1回）
        verify(
          container
              .read(githubApiRepositoryProvider)
              .fetchUsers(since: 19, perPage: 20),
        ).called(1); // 注入したMockの関数が1回呼ばれていること（onFetchMoreで1回）

        await container.pump(); // Providerが再構築されるまで待つ

        expect(
          container.exists(githubUsersControllerProvider),
          isFalse,
        ); // 破棄されたことを確認
      },
    );
  });

  /// 異常系テストケース
  group('[異常系] GithubUsersController オフラインテスト', () {
    late final MockGithubApiRepository mockGithubApiRepository;

    /// 前処理（テスト前に1回呼ばれる）
    setUpAll(() {
      mockGithubApiRepository = MockGithubApiRepository();
    });

    /// 後処理（テスト後に毎回呼ばれる）
    tearDown(() {
      reset(mockGithubApiRepository); // セットされたデータを初期化するためにモックをリセットする
    });

    test(
      'ユーザーリスト取得でAppExceptionが発生した場合、エラーになること',
      () async {
        /// Mockにデータをセットする
        final appException = AppException.error('error');
        when(mockGithubApiRepository.fetchUsers(since: 0, perPage: 20))
            .thenThrow(
          appException,
        );

        /// ProviderにMockをセットする
        final container = createContainer(
          overrides: [
            githubApiRepositoryProvider.overrideWithValue(
              mockGithubApiRepository,
            ),
          ],
        );

        /// テスト実施
        try {
          await container.read(
            githubUsersControllerProvider.future,
          ); // build内が処理されるまで待つ
          fail('failed');
        } on Exception catch (_) {}

        expect(
          container.exists(githubUsersControllerProvider),
          isTrue,
        ); // Providerのインスタンスが生成されていることを確認
        expect(
          container.read(githubUsersControllerProvider).error,
          appException,
        ); // リ
        expect(
          container.read(githubUsersControllerProvider).asData?.value.length,
          isNull,
        ); // リスト個数が期待値であるか確認

        verify(
          container
              .read(githubApiRepositoryProvider)
              .fetchUsers(since: 0, perPage: 20),
        ).called(1); // 注入したMockの関数が1回呼ばれていること（buildで1回）

        await container.pump(); // Providerが再構築されるまで待つ

        expect(
          container.exists(githubUsersControllerProvider),
          isFalse,
        ); // 破棄されたことを確認
      },
    );
  });
}
