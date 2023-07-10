import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_template/model/repositories/firebase_auth/auth_error_code.dart';
import 'package:flutter_app_template/model/repositories/firebase_auth/firebase_auth_repository.dart';
import 'package:flutter_app_template/presentation/pages/sample/auth_with_email/sign_up_with_email_page.dart';
import 'package:flutter_app_template/presentation/widgets/buttons/rounded_button.dart';
import 'package:flutter_app_template/utils/logger.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'sign_up_with_email_page_test.mocks.dart';

/// Widget tests
/// https://docs.flutter.dev/testing#widget-tests
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
  group('[正常系] SignUpWithEmailPage オフラインテスト', () {
    late final MockFirebaseAuthRepository mockFirebaseAuthRepository;

    /// 前処理（テスト前に1回呼ばれる）
    setUpAll(() {
      mockFirebaseAuthRepository = MockFirebaseAuthRepository();
    });

    /// 後処理（テスト後に毎回呼ばれる）
    tearDown(() {
      reset(mockFirebaseAuthRepository); // セットされたデータを初期化するためにモックをリセットする
    });

    testWidgets('メールアドレスとパスワードを入力して、アカウント作成できること', (tester) async {
      /// Mockにデータをセットする
      when(
        mockFirebaseAuthRepository.createUserWithEmailAndPassword(
          email,
          password,
        ),
      ).thenAnswer((_) async {
        return MockUserCredential();
      });

      /// Widgetを構築
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            // ProviderにMockをセットする
            firebaseAuthRepositoryProvider.overrideWithValue(
              mockFirebaseAuthRepository,
            ),
          ],
          child: const MaterialApp(
            home: SignUpWithEmailPage(),
          ),
        ),
      );

      /// テスト実施
      await tester.enterText(
        find.descendant(
          of: find.byKey(const Key('emailTextField')),
          matching: find.byType(TextFormField),
        ),
        email,
      ); // メールアドレスを入力
      await tester.enterText(
        find.descendant(
          of: find.byKey(const Key('passwordTextField')),
          matching: find.byType(TextFormField),
        ),
        password,
      ); // パスワードを入力
      await tester.enterText(
        find.descendant(
          of: find.byKey(const Key('confirmPasswordTextField')),
          matching: find.byType(TextFormField),
        ),
        password,
      ); // 確認用パスワードを入力
      await tester.tap(find.byType(RoundedButton)); // ボタンをタップ
      await tester.pumpAndSettle(); // アニメーションが発生するので終わるまで待ち、処理後の状態を反映する
      expect(find.text('新規登録しました'), findsOneWidget); // 期待する文言が表示されていること
    });
  });

  /// 異常系テストケース
  group('[異常系] SignUpWithEmailPage オフラインテスト', () {
    late final MockFirebaseAuthRepository mockFirebaseAuthRepository;

    /// 前処理（テスト前に1回呼ばれる）
    setUpAll(() {
      mockFirebaseAuthRepository = MockFirebaseAuthRepository();
    });

    /// 後処理（テスト後に毎回呼ばれる）
    tearDown(() {
      reset(mockFirebaseAuthRepository); // セットされたデータを初期化するためにモックをリセットする
    });

    testWidgets('メールアドレスとパスワードを入力して、「このアカウントは既に存在します」エラーが発生すること',
        (tester) async {
      /// Mockにデータをセットする
      when(
        mockFirebaseAuthRepository.createUserWithEmailAndPassword(
          email,
          password,
        ),
      ).thenThrow(
        FirebaseAuthException(code: AuthErrorCode.emailAlreadyInUse.value),
      );

      /// Widgetを構築
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            // ProviderにMockをセットする
            firebaseAuthRepositoryProvider.overrideWithValue(
              mockFirebaseAuthRepository,
            ),
          ],
          child: const MaterialApp(
            home: SignUpWithEmailPage(),
          ),
        ),
      );

      /// テスト実施
      await tester.enterText(
        find.descendant(
          of: find.byKey(const Key('emailTextField')),
          matching: find.byType(TextFormField),
        ),
        email,
      ); // メールアドレスを入力
      await tester.enterText(
        find.descendant(
          of: find.byKey(const Key('passwordTextField')),
          matching: find.byType(TextFormField),
        ),
        password,
      ); // パスワードを入力
      await tester.enterText(
        find.descendant(
          of: find.byKey(const Key('confirmPasswordTextField')),
          matching: find.byType(TextFormField),
        ),
        password,
      ); // 確認用パスワードを入力
      await tester.tap(find.byType(RoundedButton)); // ボタンをタップ
      await tester.pumpAndSettle(); // アニメーションが発生するので終わるまで待ち、処理後の状態を反映する
      expect(
        find.text('このアカウントは既に存在します'),
        findsOneWidget,
      ); // 期待する文言が表示されていること
    });
  });
}
