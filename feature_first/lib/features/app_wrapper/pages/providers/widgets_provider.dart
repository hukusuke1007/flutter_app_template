import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../github_users/pages/github_users_page.dart';
import '../../../home/pages/home_page.dart';
import '../../../memo/pages/memo_page.dart';
import '../../../setting/pages/setting_page.dart';

final widgetsProvider =
    Provider.autoDispose<List<(GlobalKey<NavigatorState>, String, Widget)>>(
  (ref) => [
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
