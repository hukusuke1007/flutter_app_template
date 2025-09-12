import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_template/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

/// Integration tests
/// https://docs.flutter.dev/testing#integration-tests
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('[正常系] GithubUsersPage E2Eテスト', () {
    testWidgets('ユーザーリストを一番下までスクロールして、期待する情報が表示されること', (tester) async {
      /// メイン画面が表示されるまで待つ
      app.main().ignore();
      await tester.pumpAndSettle();

      /// Github Users画面へ移動
      await tester.tap(find.text('タブ2'));
      await tester.pumpAndSettle();

      /// 現在表示されている状態を確認
      expect(
        find.text('Github Users'),
        findsOneWidget,
      ); // 期待する状態のWidgetが1つ見つかること

      /// 下までスクロールする（十分な距離をフリック）
      final listFinder = find.byType(Scrollable);
      await tester.fling(listFinder, const Offset(0, -2000), 2000);
      await tester.pumpAndSettle();

      /// ページング処理をし、さらに下までスクロールする（再度フリック）
      await tester.fling(listFinder, const Offset(0, -2000), 2000);
      await tester.pumpAndSettle();
    });
  });
}
