import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_template/extensions/string_extension.dart';
import 'package:flutter_app_template/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

/// Integration tests
/// https://docs.flutter.dev/testing#integration-tests
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('[正常系] LocalCounterPage E2Eテスト', () {
    testWidgets('カウントアップ/ダウンして、期待する数値が表示されること', (tester) async {
      /// メイン画面が表示されるまで待つ
      unawaited(app.main());
      await tester.pumpAndSettle();

      /// ローカルカウンター画面へ移動
      await tester.tap(find.text('ローカルカウンターのサンプル'));
      await tester.pumpAndSettle();

      /// 現在表示されている状態を確認
      final text = tester.firstWidget(find.byKey(const Key('counter'))) as Text;
      final textData = text.data ?? '0';
      expect(find.text(textData), findsOneWidget); // 期待する状態のWidgetが1つ見つかること

      var counter = textData.toInt();

      /// カウントアップを確認
      await tester.tap(find.byIcon(Icons.add)); // ボタンタップ
      await tester.pumpAndSettle(); // アニメーションが終わるまで待ち、処理後の状態を反映する
      counter += 1;
      expect(
        find.text('$counter'),
        findsOneWidget,
      ); // 期待する状態のWidgetが1つ見つかること

      /// カウントダウンを確認
      await tester.tap(find.byIcon(Icons.remove)); // ボタンタップ
      await tester.pumpAndSettle(); // アニメーションが終わるまで待ち、処理後の状態を反映する
      counter -= 1;
      expect(
        find.text('$counter'),
        findsOneWidget,
      ); // 期待する状態のWidgetが1つ見つかること
    });
  });
}
