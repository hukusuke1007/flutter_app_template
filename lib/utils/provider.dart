import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// NavigatorState
final navigatorKeyProvider = Provider((_) => GlobalKey<NavigatorState>());

/// ScrollController
typedef HashCode = int;

final scrollControllerProviders =
    Provider.family.autoDispose<ScrollController, HashCode>(
  (ref, _) {
    final scrollController = ScrollController();
    ref.onDispose(scrollController.dispose);
    return scrollController;
  },
);

/// タブのタップ操作
typedef PageName = String;

enum TabTapOperationType {
  duplication,
}

final tabTapOperationProviders =
    Provider.family.autoDispose<TabTapOperation, PageName>((ref, _) {
  final tabTapAction = TabTapOperation();
  ref.onDispose(tabTapAction.dispose);
  return tabTapAction;
});

class TabTapOperation {
  void Function(TabTapOperationType)? _listener;

  void addListener(void Function(TabTapOperationType) listener) {
    _listener = listener;
  }

  void call(TabTapOperationType actionType) {
    _listener?.call(actionType);
  }

  void dispose() {
    _listener = null;
  }
}
