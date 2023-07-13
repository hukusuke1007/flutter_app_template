import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../model/repositories/firebase_auth/firebase_auth_repository.dart';
import '../model/repositories/firebase_auth/login_type.dart';

/// NavigatorState
final navigatorKeyProvider = Provider((_) => GlobalKey<NavigatorState>());

/// 認証状態
enum AuthState {
  /// サインインしていない
  noSignIn,

  /// 匿名認証
  signInWithAnonymously,

  /// サインインしている
  signIn;

  bool get isSignIn => this != noSignIn;
}

final authStateProvider = StateProvider<AuthState>((ref) {
  final repository = ref.watch(firebaseAuthRepositoryProvider);
  final loginType = repository.loginType;
  switch (loginType) {
    case null:
      return AuthState.noSignIn;
    case LoginType.email:
      return AuthState.signIn;
    case LoginType.anonymously:
      return AuthState.signInWithAnonymously;
    case LoginType.apple:
    case LoginType.google:
      return AuthState.signIn;
  }
});

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
