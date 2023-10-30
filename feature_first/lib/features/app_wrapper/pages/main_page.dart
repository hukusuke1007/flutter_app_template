import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:page_transition/page_transition.dart';

import '../../../core/utils/tab_tap_operation_provider.dart';
import 'widgets/tab_navigator.dart';
import 'widgets_provider.dart';

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
    final widgets = ref.watch(widgetsProvider);
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
              final pageName = ref.read(widgetsProvider)[index].$2;
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
