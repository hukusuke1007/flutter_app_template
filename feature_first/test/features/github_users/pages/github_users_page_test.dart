// ignore_for_file: scoped_providers_should_specify_dependencies
import 'package:flutter/material.dart';
import 'package:flutter_app_template/core/utils/logger.dart';
import 'package:flutter_app_template/features/github_users/entities/user.dart';
import 'package:flutter_app_template/features/github_users/pages/github_users_page.dart';
import 'package:flutter_app_template/features/github_users/repositories/github_api_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
 

import 'github_users_page_test.mocks.dart';

/// Widget tests
/// https://docs.flutter.dev/testing#widget-tests
/// https://docs.flutter.dev/cookbook/testing/unit/mocking
@GenerateNiceMocks(
  [MockSpec<GithubApiRepository>()],
)
void main() {
  /// 前処理（テスト前に1回呼ばれる）
  setUpAll(Logger.configure);

  /// 正常系テストケース
  group('[正常系] GithubUsersPage オフラインテスト', () {
    late final MockGithubApiRepository mockGithubApiRepository;

    /// 前処理（テスト前に1回呼ばれる）
    setUpAll(() {
      mockGithubApiRepository = MockGithubApiRepository();
    });

    /// 後処理（テスト後に毎回呼ばれる）
    tearDown(() {
      reset(mockGithubApiRepository); // セットされたデータを初期化するためにモックをリセットする
    });

    testWidgets('ユーザーリストを一番下までスクロールして、期待する情報が表示されること', (tester) async {
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

      /// Widgetを構築
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            // ProviderにMockをセットする
            githubApiRepositoryProvider.overrideWithValue(
              mockGithubApiRepository,
            ),
          ],
          child: const MaterialApp(
            home: GithubUsersPage(),
          ),
        ),
      );
      await tester.pump(); // Providerの非同期buildが処理されるので、処理後の状態を反映する

      /// テスト実施（初回表示）
      final listFinder = find.byType(Scrollable);
      final item1Finder = find.text('User 19'); // リストの最後の情報を見つける
      await tester.scrollUntilVisible(
        item1Finder,
        500,
        scrollable: listFinder,
      );
      expect(item1Finder, findsOneWidget); // 期待する状態のWidgetが1つ見つかること

      /// テスト実施（ページング後）
      final item2Finder = find.text('User 39'); // ページング処理後、リストの最後の情報を見つける
      await tester.scrollUntilVisible(
        item2Finder,
        500,
        scrollable: listFinder,
      );
      await tester.pumpAndSettle();
      expect(item2Finder, findsOneWidget); // 期待する状態のWidgetが1つ見つかること
    });
  });
}
