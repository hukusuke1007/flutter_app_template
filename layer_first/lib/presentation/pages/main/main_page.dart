import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../utils/tab_tap_operation_provider.dart';
import '../github_users/github_users_page.dart';
import '../local_counter/local_counter_page.dart';
import 'tab_navigator.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({super.key});

  static String get pageName => 'main';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widgetsState =
        useState<List<(GlobalKey<NavigatorState>, String, Widget)>>(
      [
        (
          GlobalKey<NavigatorState>(),
          LocalCounterPage.pageName,
          const LocalCounterPage(),
        ),
        (
          GlobalKey<NavigatorState>(),
          GithubUsersPage.pageName,
          const GithubUsersPage(),
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
