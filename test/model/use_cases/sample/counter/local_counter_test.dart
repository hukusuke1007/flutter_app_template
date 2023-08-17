import 'package:flutter_app_template/model/repositories/shared_preferences/shared_preference_key.dart';
import 'package:flutter_app_template/model/repositories/shared_preferences/shared_preference_repository.dart';
import 'package:flutter_app_template/model/use_cases/sample/counter/local_counter.dart';
import 'package:flutter_app_template/utils/logger.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../utils.dart';
import 'local_counter_test.mocks.dart';

/// Unit tests
/// https://docs.flutter.dev/testing#unit-tests
/// https://docs.flutter.dev/cookbook/testing/unit/mocking
@GenerateNiceMocks(
  [MockSpec<SharedPreferencesRepository>()],
)
void main() {
  /// 前処理（テスト前に1回呼ばれる）
  setUpAll(Logger.configure);

  /// 正常系テストケース
  group('[正常系] LocalCounter オフラインテスト（モック）', () {
    late final MockSharedPreferencesRepository mockSharedPreferencesRepository;

    /// 前処理（テスト前に1回呼ばれる）
    setUpAll(() {
      mockSharedPreferencesRepository = MockSharedPreferencesRepository();
    });

    /// 後処理（テスト後に毎回呼ばれる）
    tearDown(() {
      reset(mockSharedPreferencesRepository); // セットされたデータを初期化するためにモックをリセットする
    });

    test(
      'カウントアップ/ダウンできること',
      () async {
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

        /// MockをProviderにセットし、テスト実施
        final container = createContainer(
          overrides: [
            sharedPreferencesRepositoryProvider.overrideWithValue(
              mockSharedPreferencesRepository,
            ),
          ],
        )..read(localCounterProvider);

        expect(
          container.exists(localCounterProvider),
          isTrue,
        ); // Providerのインスタンスが生成されていることを確認
        expect(container.read(localCounterProvider), 0); // 期待値になっていること

        await container
            .read(localCounterProvider.notifier)
            .increment(); // カウントアップ
        expect(container.read(localCounterProvider), 1); // 期待値になっていること

        await container
            .read(localCounterProvider.notifier)
            .decrement(); // カウントダウン
        expect(container.read(localCounterProvider), 0); // 期待値になっていること

        verify(
          container
              .read(sharedPreferencesRepositoryProvider)
              .fetch<int>(SharedPreferencesKey.sampleLocalCounter),
        ).called(1); // 注入したMockの関数が1回呼ばれていること
        verify(
          container
              .read(sharedPreferencesRepositoryProvider)
              .save(SharedPreferencesKey.sampleLocalCounter, any),
        ).called(2); // 注入したMockの関数が1回呼ばれていること
      },
    );
  });
}
