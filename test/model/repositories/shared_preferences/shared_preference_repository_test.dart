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
  group('[正常系] GithubApiRepository オフラインテスト', () {
    late final MockSharedPreferences sharedPreferences;
    late final SharedPreferencesRepository sharedPreferencesRepository;

    /// 前処理（テスト前に1回呼ばれる）
    setUpAll(() {
      sharedPreferences = MockSharedPreferences();
      sharedPreferencesRepository =
          SharedPreferencesRepository(sharedPreferences);
    });

    /// 後処理（テスト後に毎回呼ばれる）
    tearDown(() {
      reset(sharedPreferences); // セットされたデータを初期化するためにモックをリセットする
    });

    test(
      'サポートされている型でデータが保存できること',
      () async {
        /// Mockにデータをセットする
        when(
          sharedPreferences.setInt(key.value, any),
        ).thenAnswer((_) async => true);
        when(
          sharedPreferences.setDouble(key.value, any),
        ).thenAnswer((_) async => true);
        when(
          sharedPreferences.setBool(key.value, any),
        ).thenAnswer((_) async => true);
        when(
          sharedPreferences.setString(key.value, any),
        ).thenAnswer((_) async => true);
        when(
          sharedPreferences.setStringList(key.value, any),
        ).thenAnswer((_) async => true);

        /// MockをProviderにセットする
        final container = createContainer(
          overrides: [
            sharedPreferencesRepositoryProvider
                .overrideWith((ref) => sharedPreferencesRepository)
          ],
        );

        /// テスト実施
        await container
            .read(sharedPreferencesRepositoryProvider)
            .save<int>(key, 0);
        await container
            .read(sharedPreferencesRepositoryProvider)
            .save<double>(key, 0.1);
        await container
            .read(sharedPreferencesRepositoryProvider)
            .save<bool>(key, true);
        await container
            .read(sharedPreferencesRepositoryProvider)
            .save<String>(key, '0');
        await container
            .read(sharedPreferencesRepositoryProvider)
            .save<List<String>>(key, ['0', '1']);

        /// テスト結果を検証 注入したMockの関数が1回呼ばれていること
        verify(sharedPreferences.setInt(key.value, any)).called(1);
        verify(sharedPreferences.setDouble(key.value, any)).called(1);
        verify(sharedPreferences.setBool(key.value, any)).called(1);
        verify(sharedPreferences.setString(key.value, any)).called(1);
        verify(sharedPreferences.setStringList(key.value, any)).called(1);
      },
    );

    test(
      'サポートされている型でデータが取得ができること',
      () async {
        /// Mockにデータをセットする
        when(
          sharedPreferences.getInt(key.value),
        ).thenAnswer((_) => 0);
        when(
          sharedPreferences.getDouble(key.value),
        ).thenAnswer((_) => 0.1);
        when(
          sharedPreferences.getBool(key.value),
        ).thenAnswer((_) => true);
        when(
          sharedPreferences.getString(key.value),
        ).thenAnswer((_) => '0');
        when(
          sharedPreferences.getStringList(key.value),
        ).thenAnswer((_) => ['0', '1']);

        /// MockをProviderにセットする
        final container = createContainer(
          overrides: [
            sharedPreferencesRepositoryProvider
                .overrideWith((ref) => sharedPreferencesRepository)
          ],
        );

        /// テスト実施して結果を検証
        expect(
          container.read(sharedPreferencesRepositoryProvider).fetch<int>(key),
          0,
        );
        expect(
          container
              .read(sharedPreferencesRepositoryProvider)
              .fetch<double>(key),
          0.1,
        );
        expect(
          container.read(sharedPreferencesRepositoryProvider).fetch<bool>(key),
          true,
        );
        expect(
          container
              .read(sharedPreferencesRepositoryProvider)
              .fetch<String>(key),
          '0',
        );
        expect(
          container
              .read(sharedPreferencesRepositoryProvider)
              .fetch<List<String>>(key),
          ['0', '1'],
        );

        /// 注入したMockの関数が1回呼ばれていること
        verify(sharedPreferences.getInt(key.value)).called(1);
        verify(sharedPreferences.getDouble(key.value)).called(1);
        verify(sharedPreferences.getBool(key.value)).called(1);
        verify(sharedPreferences.getString(key.value)).called(1);
        verify(sharedPreferences.getStringList(key.value)).called(1);
      },
    );
  });
}
