import 'package:flutter/material.dart';
import 'package:flutter_app_template/model/repositories/shared_preferences/shared_preference_key.dart';
import 'package:flutter_app_template/model/repositories/shared_preferences/shared_preference_repository.dart';
import 'package:flutter_app_template/presentation/pages/sample/local_counter/local_counter_page.dart';
import 'package:flutter_app_template/utils/logger.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'local_counter_page_test.mocks.dart';

/// Widget tests
/// https://docs.flutter.dev/testing#widget-tests
/// https://docs.flutter.dev/cookbook/testing/unit/mocking
@GenerateNiceMocks(
  [MockSpec<SharedPreferencesRepository>()],
)
void main() {
  /// 前処理（テスト前に1回呼ばれる）
  setUpAll(Logger.configure);

  /// 正常系テストケース
  group('[正常系] LocalCounterPage オフラインテスト', () {
    late final MockSharedPreferencesRepository mockSharedPreferencesRepository;

    /// 前処理（テスト前に1回呼ばれる）
    setUpAll(() {
      mockSharedPreferencesRepository = MockSharedPreferencesRepository();
    });

    /// 後処理（テスト後に毎回呼ばれる）
    tearDown(() {
      reset(mockSharedPreferencesRepository); // セットされたデータを初期化するためにモックをリセットする
    });

    testWidgets('カウントアップして、期待する数値が表示されること', (tester) async {
      /// Mockにデータをセットする
      when(
        mockSharedPreferencesRepository
            .fetch<int>(SharedPreferencesKey.sampleLocalCounter),
      ).thenAnswer((_) => 0);
      when(
        mockSharedPreferencesRepository.save<int>(
          SharedPreferencesKey.sampleLocalCounter,
          any,
        ),
      ).thenAnswer((_) async => true);

      /// Widgetを構築
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            // ProviderにMockをセットする
            sharedPreferencesRepositoryProvider.overrideWithValue(
              mockSharedPreferencesRepository,
            ),
          ],
          child: const MaterialApp(
            home: LocalCounterPage(),
          ),
        ),
      );

      /// テスト実施（操作する）
      await tester.tap(find.byIcon(Icons.add)); // ボタンタップ
      await tester.pump(); // リビルドして状態を反映

      /// テスト結果を検証
      expect(find.text('1'), findsOneWidget); // 期待する状態のWidgetが1つ見つかること
    });

    testWidgets('カウントダウンして、期待する数値が表示されること', (tester) async {
      /// Mockにデータをセットする
      when(
        mockSharedPreferencesRepository
            .fetch<int>(SharedPreferencesKey.sampleLocalCounter),
      ).thenAnswer((_) => 0);
      when(
        mockSharedPreferencesRepository.save(
          SharedPreferencesKey.sampleLocalCounter,
          any,
        ),
      ).thenAnswer((_) async => true);

      /// Widgetを構築
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            // ProviderにMockをセットする
            sharedPreferencesRepositoryProvider.overrideWithValue(
              mockSharedPreferencesRepository,
            ),
          ],
          child: const MaterialApp(
            home: LocalCounterPage(),
          ),
        ),
      );

      /// テスト実施（操作する）
      await tester.tap(find.byIcon(Icons.remove)); // ボタンタップ
      await tester.pump(); // リビルドして状態を反映

      /// テスト結果を検証
      expect(find.text('-1'), findsOneWidget); // 期待する状態のWidgetが1つ見つかること
    });
  });
}
