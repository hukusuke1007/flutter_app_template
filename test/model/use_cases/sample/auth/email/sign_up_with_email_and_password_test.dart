import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app_template/exceptions/app_exception.dart';
import 'package:flutter_app_template/model/repositories/firebase_auth/auth_error_code.dart';
import 'package:flutter_app_template/model/repositories/firebase_auth/firebase_auth_repository.dart';
import 'package:flutter_app_template/model/use_cases/sample/auth/email/sign_up_with_email_and_password.dart';
import 'package:flutter_app_template/utils/logger.dart';
import 'package:flutter_app_template/utils/provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../utils.dart';
import 'sign_up_with_email_and_password_test.mocks.dart';

/// Unit tests
/// https://docs.flutter.dev/testing#unit-tests
/// https://docs.flutter.dev/cookbook/testing/unit/mocking
@GenerateNiceMocks(
  [MockSpec<FirebaseAuthRepository>(), MockSpec<UserCredential>()],
)
void main() {
  /// テストで利用する定数を定義
  const email = 'sample@sample.com';
  const password = 'Password1234';

  /// 前処理（テスト前に1回呼ばれる）
  setUpAll(Logger.configure);

  /// 正常系テストケース
  group('[正常系] SignUpWithEmailAndPassword オフラインテスト', () {
    late final MockFirebaseAuthRepository repository;

    /// 前処理（テスト前に1回呼ばれる）
    setUpAll(() {
      repository = MockFirebaseAuthRepository();
    });

    /// 後処理（テスト後に毎回呼ばれる）
    tearDown(() {
      reset(repository); // セットされたデータを初期化するためにモックをリセットする
    });

    test(
      'メールアドレス認証でアカウント作成できること',
      () async {
        /// Mockにデータをセットする
        when(repository.createUserWithEmailAndPassword(email, password))
            .thenAnswer((_) async {
          return MockUserCredential();
        });

        /// MockをProviderにセットする
        final container = createContainer(
          overrides: [
            firebaseAuthRepositoryProvider.overrideWith((ref) => repository)
          ],
        );

        /// テスト実施して結果を取得
        try {
          await container.read(signUpWithEmailAndPasswordProvider)(
            email: email,
            password: password,
          );

          /// テスト結果を検証
          verify(repository.createUserWithEmailAndPassword(email, password))
              .called(1); // 注入したMockの関数が1回呼ばれていること
          expect(
            container.read(authStateProvider),
            AuthState.signIn,
          ); // 期待する状態であること
        } on Exception catch (_) {
          fail('failed');
        }
      },
    );
  });

  /// 異常系テストケース
  group('[異常系] SignUpWithEmailAndPassword オフラインテスト', () {
    late final MockFirebaseAuthRepository repository;

    /// 前処理（テスト前に1回呼ばれる）
    setUpAll(() {
      repository = MockFirebaseAuthRepository();
    });

    /// 後処理（テスト後に毎回呼ばれる）
    tearDown(() {
      reset(repository); // セットされたデータを初期化するためにモックをリセットする
    });

    test('メールアドレス認証でエラーが発生した場合、「このアカウントは既に存在します」エラーが発生すること', () async {
      /// Mockにデータをセットする
      when(repository.createUserWithEmailAndPassword(email, password))
          .thenThrow(
        FirebaseAuthException(code: AuthErrorCode.emailAlreadyInUse.value),
      );

      /// MockをProviderにセットする
      final container = createContainer(
        overrides: [
          firebaseAuthRepositoryProvider.overrideWith((ref) => repository)
        ],
      );

      /// テスト実施して結果を取得
      try {
        await container.read(signUpWithEmailAndPasswordProvider)(
          email: email,
          password: password,
        );
        fail('failed');
      } on AppException catch (e) {
        /// テスト結果を検証
        verify(repository.createUserWithEmailAndPassword(email, password))
            .called(1); // 注入したMockの関数が1回呼ばれていること
        expect(e.title, 'このアカウントは既に存在します');
        expect(
          container.read(authStateProvider),
          AuthState.noSignIn,
        ); // 期待する状態であること
      } on Exception catch (_) {
        fail('failed');
      }
    });
  });
}