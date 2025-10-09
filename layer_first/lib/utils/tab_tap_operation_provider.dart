import 'package:hooks_riverpod/hooks_riverpod.dart';

typedef PageName = String;

enum TabTapOperationType { duplication }

final tabTapOperationProviders = Provider.family<TabTapOperation, PageName>((
  ref,
  _,
) {
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
