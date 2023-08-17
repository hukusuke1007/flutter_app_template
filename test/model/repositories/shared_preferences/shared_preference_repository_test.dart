import 'package:flutter_app_template/model/repositories/shared_preferences/shared_preference_key.dart';
import 'package:flutter_app_template/model/repositories/shared_preferences/shared_preference_repository.dart';
import 'package:flutter_app_template/utils/logger.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils.dart';
import 'shared_preference_repository_test.mocks.dart';

/// Unit tests
/// https://docs.flutter.dev/testing#unit-tests
/// https://docs.flutter.dev/cookbook/testing/unit/mocking
@GenerateNiceMocks([MockSpec<SharedPreferences>()])
void main() {
  /// テストで利用する定数を定義
  const key = SharedPreferencesKey.sampleLocalCounter;

  /// 前処理（テスト前に1回呼ばれる）
  setUpAll(Logger.configure);

  /// 正常系テストケース
  group('[正常系] SharedPreferencesRepository オフラインテスト', () {
    late final MockSharedPreferences mockSharedPreferences;

    /// 前処理（テスト前に1回呼ばれる）
    setUpAll(() {
      mockSharedPreferences = MockSharedPreferences();
    });

    /// 後処理（テスト後に毎回呼ばれる）
    tearDown(() {
      reset(mockSharedPreferences); // セットされたデータを初期化するためにモックをリセットする
    });

    test(
      'サポートされている型でデータが保存できること',
      () async {
        /// Mockにデータをセットする
        when(
          mockSharedPreferences.setInt(key.value, any),
        ).thenAnswer((_) async => true);
        when(
          mockSharedPreferences.setDouble(key.value, any),
        ).thenAnswer((_) async => true);
        when(
          mockSharedPreferences.setBool(key.value, any),
        ).thenAnswer((_) async => true);
        when(
          mockSharedPreferences.setString(key.value, any),
        ).thenAnswer((_) async => true);
        when(
          mockSharedPreferences.setStringList(key.value, any),
        ).thenAnswer((_) async => true);

        /// ProviderにMockをセットする
        final container = createContainer(
          overrides: [
            sharedPreferencesRepositoryProvider.overrideWith(
              (ref) => SharedPreferencesRepository(mockSharedPreferences),
            ),
          ],
        );

        /// テスト実施
        final repository = container.read(sharedPreferencesRepositoryProvider);
        final results = await [
          repository.save<int>(key, 0),
          repository.save<double>(key, 0.1),
          repository.save<bool>(key, true),
          repository.save<String>(key, '0'),
          repository.save<List<String>>(key, ['0', '1']),
        ].wait;

        for (final element in results) {
          expect(element, isTrue);
        }

        /// テスト結果を検証 注入したMockの関数が1回呼ばれていること
        verify(mockSharedPreferences.setInt(key.value, 0)).called(1);
        verify(mockSharedPreferences.setDouble(key.value, 0.1)).called(1);
        verify(mockSharedPreferences.setBool(key.value, true)).called(1);
        verify(mockSharedPreferences.setString(key.value, '0')).called(1);
        verify(mockSharedPreferences.setStringList(key.value, ['0', '1']))
            .called(1);
      },
    );

    test(
      'サポートされている型でデータが取得できること',
      () async {
        /// Mockにデータをセットする
        when(
          mockSharedPreferences.getInt(key.value),
        ).thenAnswer((_) => 0);
        when(
          mockSharedPreferences.getDouble(key.value),
        ).thenAnswer((_) => 0.1);
        when(
          mockSharedPreferences.getBool(key.value),
        ).thenAnswer((_) => true);
        when(
          mockSharedPreferences.getString(key.value),
        ).thenAnswer((_) => '0');
        when(
          mockSharedPreferences.getStringList(key.value),
        ).thenAnswer((_) => ['0', '1']);

        /// ProviderにMockをセットする
        final container = createContainer(
          overrides: [
            sharedPreferencesRepositoryProvider.overrideWith(
              (ref) => SharedPreferencesRepository(mockSharedPreferences),
            ),
          ],
        );

        /// テスト実施して結果を検証
        final repository = container.read(sharedPreferencesRepositoryProvider);
        expect(repository.fetch<int>(key), 0);
        expect(repository.fetch<double>(key), 0.1);
        expect(repository.fetch<bool>(key), true);
        expect(repository.fetch<String>(key), '0');
        expect(repository.fetch<List<String>>(key), ['0', '1']);

        /// 注入したMockの関数が1回呼ばれていること
        verify(mockSharedPreferences.getInt(key.value)).called(1);
        verify(mockSharedPreferences.getDouble(key.value)).called(1);
        verify(mockSharedPreferences.getBool(key.value)).called(1);
        verify(mockSharedPreferences.getString(key.value)).called(1);
        verify(mockSharedPreferences.getStringList(key.value)).called(1);
      },
    );
  });
}
