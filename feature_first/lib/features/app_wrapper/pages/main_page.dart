import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:page_transition/page_transition.dart';

import '../../../core/utils/tab_tap_operation_provider.dart';
import '../../github_users/pages/github_users_page.dart';
import '../../home/pages/home_page.dart';
import '../../memo/pages/memo_page.dart';
import '../../setting/pages/setting_page.dart';
import 'widgets/tab_navigator.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({super.key});

  static String get pageName => 'main';
  static String get pagePath => '/$pageName';

  /// go_routerの画面遷移
  static void go(BuildContext context) {
    context.go(pagePath);
  }

  /// 従来の画面遷移
  static Future<void> showNav1(BuildContext context) =>
      Navigator.of(context, rootNavigator: true).pushReplacement<void, void>(
        PageTransition(
          type: PageTransitionType.fade,
          child: const MainPage(),
          duration: const Duration(milliseconds: 500),
          settings: RouteSettings(name: pageName),
        ),
      );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widgetsState =
        useState<List<(GlobalKey<NavigatorState>, String, Widget)>>(
      [
        (
          GlobalKey<NavigatorState>(),
          HomePage.pageName,
          const HomePage(),
        ),
        (
          GlobalKey<NavigatorState>(),
          GithubUsersPage.pageName,
          const GithubUsersPage()
        ),
        (
          GlobalKey<NavigatorState>(),
          MemoPage.pageName,
          const MemoPage(),
        ),
        (
          GlobalKey<NavigatorState>(),
          SettingPage.pageName,
          const SettingPage(),
        ),
      ],
    );
    final widgets = widgetsState.value;

    final selectedTabIndexState = useState(0);
    final selectedTabIndex = selectedTabIndexState.value;

    return WillPopScope(
      onWillPop: () async {
        final keyTab = widgets[selectedTabIndex].$1;
        final currentState = keyTab.currentState;
        if (currentState != null && currentState.canPop()) {
          final maybePop = await currentState.maybePop();
          return !maybePop;
        }
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: IndexedStack(
          index: selectedTabIndex,
          children: List.generate(
            widgets.length,
            (index) => TabNavigator(
              navigatorKey: widgets[index].$1,
              page: widgets[index].$3,
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'タブ1',
              tooltip: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'タブ2',
              tooltip: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.edit),
              label: 'タブ3',
              tooltip: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'タブ4',
              tooltip: '',
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedTabIndex,
          onTap: (index) {
            /// 同じタブが選択されたことを通知する
            if (index == selectedTabIndex) {
              final pageName = widgets[index].$2;
              ref
                  .read(tabTapOperationProviders(pageName))
                  .call(TabTapOperationType.duplication);
            }

            /// タブを切り替える
            selectedTabIndexState.value = index;
          },
          selectedFontSize: 12,
        ),
      ),
    );
  }
}
