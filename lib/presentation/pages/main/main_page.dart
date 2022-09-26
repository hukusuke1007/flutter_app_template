import 'package:flutter/material.dart';
import 'package:flutter_app_template/presentation/pages/sample/memo/memo_page.dart';
import 'package:flutter_app_template/presentation/pages/sample/setting/setting_page.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../extensions/context_extension.dart';
import '../sample/github_users/with_state_notifier/github_users_page.dart';
import '../sample/home/home_page.dart';

class MainPage extends HookConsumerWidget {
  const MainPage(
    this.child, {
    super.key,
  });

  static String get pageName => 'main_page';
  static String get pagePath => pageName;

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      onWillPop: () async {
        // TODO(shohei): 未実装
        // final keyTab = navigatorKeys.value[selectedIndex.value];
        // if (keyTab.currentState != null && keyTab.currentState!.canPop()) {
        //   return !await keyTab.currentState!.maybePop();
        // }
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: child,
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
              label: 'タブ5',
              tooltip: '',
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _calculateSelectedIndex(context),
          showSelectedLabels: !context.isIphoneMiniSize,
          showUnselectedLabels: !context.isIphoneMiniSize,
          onTap: (index) {
            switch (index) {
              case 0:
                context.go(HomePage.pagePath);
                break;
              case 1:
                context.go(GithubUsersPage.pagePath);
                break;
              case 2:
                context.go(MemoPage.pagePath);
                break;
              case 3:
                context.go(SettingPage.pagePath);
                break;
            }
          },
          selectedFontSize: 12,
        ),
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouter.of(context).location;
    if (location == HomePage.pagePath) {
      return 0;
    }
    if (location == GithubUsersPage.pagePath) {
      return 1;
    }
    if (location == MemoPage.pagePath) {
      return 2;
    }
    if (location == SettingPage.pagePath) {
      return 3;
    }
    return 0;
  }
}
