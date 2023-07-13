import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:page_transition/page_transition.dart';

import '../../../utils/provider.dart';
import '../sample/github_users/with_async_notifier/github_users_page.dart';
import '../sample/home/home_page.dart';
import '../sample/memo/memo_page.dart';
import '../sample/setting/setting_page.dart';
import 'tab_navigator.dart';

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

  static final widgetsProvider = Provider.autoDispose(
    (ref) => [
      const HomePage(),
      const GithubUsersPage(),
      const MemoPage(),
      const SettingPage(),
    ],
  );

  static final navigatorKeysProvider = Provider.autoDispose(
    (ref) => [
      GlobalKey<NavigatorState>(),
      GlobalKey<NavigatorState>(),
      GlobalKey<NavigatorState>(),
      GlobalKey<NavigatorState>(),
    ],
  );

  static final selectedTabIndexStateProvider =
      StateProvider.autoDispose((ref) => 0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widgets = ref.watch(widgetsProvider);
    final navigatorKeys = ref.watch(navigatorKeysProvider);
    final selectedTabIndex = ref.watch(selectedTabIndexStateProvider);

    return WillPopScope(
      onWillPop: () async {
        final keyTab = navigatorKeys[selectedTabIndex];
        if (keyTab.currentState != null && keyTab.currentState!.canPop()) {
          return !await keyTab.currentState!.maybePop();
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
              navigatorKey: navigatorKeys[index],
              page: widgets[index],
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
            /// 同じタブを選択したら上にスクロールする
            if (index == selectedTabIndex) {
              final hashCode = ref.read(widgetsProvider)[index].hashCode;
              final scrollController =
                  ref.read(scrollControllerProviders(hashCode));
              if (scrollController.hasClients) {
                scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.linear,
                );
              }
            }

            /// タブを切り替える
            ref.read(selectedTabIndexStateProvider.notifier).update(
                  (state) => index,
                );
          },
          selectedFontSize: 12,
        ),
      ),
    );
  }
}
