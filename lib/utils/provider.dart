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
  (_, __) => ScrollController(),
);
