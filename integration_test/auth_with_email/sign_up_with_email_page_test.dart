import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_template/main.dart' as app;
import 'package:flutter_app_template/presentation/widgets/buttons/rounded_button.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

/// Integration tests
/// https://docs.flutter.dev/testing#integration-tests
void main() {
  /// テストで利用する定数を定義
  final email = '${DateTime.now().millisecondsSinceEpoch}@sample.com';
  const password = 'Password1234';

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('[正常系] SignUpWithEmailPage E2Eテスト', () {
    testWidgets('サインアップして新しいアカウントが作成されること', (tester) async {
      /// メイン画面が表示されるまで待つ
      unawaited(app.main());
      await tester.pumpAndSettle();

      /// メールアドレス認証のサンプル画面へ移動
      await tester.tap(find.text('メールアドレス認証のサンプル'));
      await tester.pumpAndSettle();

      /// サインアップ画面へ移動
      await tester.tap(find.text('サインアップ'));
      await tester.pumpAndSettle();

      /// 現在表示されている状態を確認
      expect(
        find.text('サインアップ'),
        findsOneWidget,
      ); // 期待する状態のWidgetが1つ見つかること

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
      await tester.pumpAndSettle(); // アニメーションが終わるまで待ち、処理後の状態を反映する
      expect(find.text('新規登録しました'), findsOneWidget); // 期待する文言が表示されていること
    });
  });
}
