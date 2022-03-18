import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:page_transition/page_transition.dart';

import '../../../extensions/context_extension.dart';
import '../sample/firestore_counter_page.dart';
import '../sample/local_counter_page.dart';
import '../sample/memo_page.dart';
import '../sample/setting_page.dart';
import 'tab_navigator.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({Key? key}) : super(key: key);

  static Future<void> show(BuildContext context) async {
    await Navigator.of(context, rootNavigator: true)
        .pushReplacement<MaterialPageRoute<dynamic>, void>(
      PageTransition(
        type: PageTransitionType.fade,
        child: const MainPage(),
        duration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widgets = useState<List<Widget>>([
      const LocalCounterPage(),
      const FirestoreCounterPage(),
      MemoPage(),
      const SettingPage(),
    ]);
    final navigatorKeys = useState({
      0: GlobalKey<NavigatorState>(),
      1: GlobalKey<NavigatorState>(),
      2: GlobalKey<NavigatorState>(),
      3: GlobalKey<NavigatorState>(),
    });
    final selectedIndex = useState(0);

    Future<bool> onWillPop() async {
      final keyTab = navigatorKeys.value[selectedIndex.value]!;
      if (keyTab.currentState != null && keyTab.currentState!.canPop()) {
        return !await keyTab.currentState!.maybePop();
      }
      return Future.value(true);
    }

    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: List.generate(
            widgets.value.length,
            (index) => Offstage(
              offstage: index != selectedIndex.value,
              child: TabNavigator(
                navigatorKey: navigatorKeys.value[index]!,
                page: widgets.value[index],
              ),
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
              icon: Icon(Icons.edit),
              label: 'タブ2',
              tooltip: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.event_note),
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
          currentIndex: selectedIndex.value,
          showSelectedLabels: !context.isIphoneMiniSize,
          showUnselectedLabels: !context.isIphoneMiniSize,
          onTap: (index) {
            selectedIndex.value = index;
          },
          selectedFontSize: 12,
        ),
      ),
    );
  }
}
