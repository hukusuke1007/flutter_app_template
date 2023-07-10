import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_app_template/main.dart' as app;
import 'package:flutter_app_template/presentation/widgets/smart_refresher/smart_refresher_custom.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

/// Integration tests
/// https://docs.flutter.dev/testing#integration-tests
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('[正常系] GithubUsersPage E2Eテスト', () {
    testWidgets('ユーザーリストを一番下までスクロールして、期待する情報が表示されること', (tester) async {
      /// メイン画面が表示されるまで待つ
      unawaited(app.main());
      await tester.pumpAndSettle();

      /// Github Users画面へ移動
      await tester.tap(find.text('タブ2'));
      await tester.pumpAndSettle();

      /// 現在表示されている状態を確認
      expect(
        find.text('Github Users'),
        findsOneWidget,
      ); // 期待する状態のWidgetが1つ見つかること

      /// 下までスクロールする
      final listFinder = find.byType(Scrollable);
      await tester.scrollUntilVisible(
        find.byType(SmartRefreshFooter), // リストの最後の情報を見つける
        500,
        scrollable: listFinder,
      );
      await tester.pumpAndSettle(); // スクロールアニメーションが終わるまで待ち、処理後の状態を反映する
      expect(
        ((tester.firstWidget(find.byType(SmartRefresher)) as SmartRefresher)
                .child! as ListView)
            .semanticChildCount,
        20,
      ); // リストの個数が期待値であること

      /// ページング処理をし、さらに下までスクロールする
      await tester.drag(
        find.byType(SmartRefresher),
        const Offset(100, 0),
      ); // 上にスワイプ
      await tester.pumpAndSettle(); // ページング処理のアニメーションが終わるまで待ち、処理後の状態を反映する
      await tester.scrollUntilVisible(
        find.byType(SmartRefreshFooter), // リストの最後の情報を見つける
        500,
        scrollable: listFinder,
      );
      await tester.pumpAndSettle(); // スクロールアニメーションが終わるまで待ち、処理後の状態を反映する
      expect(
        ((tester.firstWidget(find.byType(SmartRefresher)) as SmartRefresher)
                .child! as ListView)
            .semanticChildCount,
        40,
      ); // リストの個数が期待値であること
    });
  });
}
