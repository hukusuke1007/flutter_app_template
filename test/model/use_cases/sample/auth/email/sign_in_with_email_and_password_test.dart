import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app_template/exceptions/app_exception.dart';
import 'package:flutter_app_template/model/repositories/firebase_auth/auth_error_code.dart';
import 'package:flutter_app_template/model/repositories/firebase_auth/firebase_auth_repository.dart';
import 'package:flutter_app_template/model/use_cases/sample/auth/email/sign_in_with_email_and_password.dart';
import 'package:flutter_app_template/utils/logger.dart';
import 'package:flutter_app_template/utils/provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../utils.dart';
import 'sign_in_with_email_and_password_test.mocks.dart';

@GenerateNiceMocks(
  [MockSpec<FirebaseAuthRepository>(), MockSpec<UserCredential>()],
)
void main() {
  /// テストで利用する定数を定義
  const email = 'sample@sample.com';
  const password = 'password';

  /// 準備（テスト実施前に1度呼ばれる）
  setUpAll(Logger.configure);

  /// 正常系テストケース
  group('[正常系] SignInWithEmailAndPasswordオフラインテスト', () {
    late final MockFirebaseAuthRepository repository;

    /// 準備（テスト実施前に毎回呼ばれる）
    setUp(() {
      repository = MockFirebaseAuthRepository();
    });

    test(
      'メールアドレス認証ができること',
      () async {
        /// Mockにデータをセットする
        when(repository.signInWithEmailAndPassword(email, password))
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
          await container.read(signInWithEmailAndPasswordProvider)(
            email: email,
            password: password,
          );

          /// テスト結果を検証
          verify(repository.signInWithEmailAndPassword(email, password))
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
  group('[異常系] SignInWithEmailAndPasswordオフラインテスト', () {
    late final MockFirebaseAuthRepository repository;

    /// 準備（テスト実施前に毎回呼ばれる）
    setUp(() {
      repository = MockFirebaseAuthRepository();
    });

    test('メールアドレス認証でエラーが発生した場合、「メールアドレスが正しくない」エラーが発生すること', () async {
      /// Mockにデータをセットする
      when(repository.signInWithEmailAndPassword(email, password)).thenThrow(
        FirebaseAuthException(code: AuthErrorCode.invalidEmail.value),
      );

      /// MockをProviderにセットする
      final container = createContainer(
        overrides: [
          firebaseAuthRepositoryProvider.overrideWith((ref) => repository)
        ],
      );

      /// テスト実施して結果を取得
      try {
        await container.read(signInWithEmailAndPasswordProvider)(
          email: email,
          password: password,
        );
        fail('failed');
      } on AppException catch (e) {
        /// テスト結果を検証
        verify(repository.signInWithEmailAndPassword(email, password))
            .called(1); // 注入したMockの関数が1回呼ばれていること
        expect(e.title, 'メールアドレスもしくはパスワードが正しくありません');
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
