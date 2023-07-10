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

@GenerateNiceMocks(
  [MockSpec<GithubApiRepository>()],
)
void main() {
  /// 準備（テスト実施前に1度呼ばれる）
  setUpAll(Logger.configure);

  /// 正常系テストケース
  group('[正常系] GithubUsersControllerオフラインテスト', () {
    late final MockGithubApiRepository repository;

    /// 準備（テスト実施前に1回呼ばれる）
    setUpAll(() {
      repository = MockGithubApiRepository();
    });

    test(
      'ユーザーリストを取得できること',
      () async {
        /// Mockにデータをセットする
        final dataList = List.generate(
          20,
          (index) => User(
            login: index.toString(),
            id: index,
            url: 'https://example/$index',
          ),
        );
        when(repository.fetchUsers(since: 0, perPage: 20))
            .thenAnswer((_) async {
          return dataList;
        });
        when(repository.fetchUsers(since: 19, perPage: 20))
            .thenAnswer((_) async {
          return dataList;
        }); // ページング取得用にセット

        /// MockをProviderにセットする
        final container = createContainer(
          overrides: [
            githubApiRepositoryProvider.overrideWith((ref) => repository)
          ],
        );

        /// テスト実施
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

        /// ページング取得を実施
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
  group('[異常系] GithubUsersControllerオフラインテスト', () {
    late final MockGithubApiRepository repository;

    /// 準備（テスト実施前に1回呼ばれる）
    setUpAll(() {
      repository = MockGithubApiRepository();
    });

    test(
      'ユーザーリスト取得でAppExceptionが発生した場合、エラーになること',
      () async {
        /// Mockにデータをセットする
        final appException = AppException.error('error');
        when(repository.fetchUsers(since: 0, perPage: 20)).thenThrow(
          appException,
        );

        /// MockをProviderにセットする
        final container = createContainer(
          overrides: [
            githubApiRepositoryProvider.overrideWith((ref) => repository)
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
