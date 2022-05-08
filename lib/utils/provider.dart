import 'package:flutter/material.dart';
import 'package:flutter_app_template/model/repositories/firebase_auth/firebase_auth_repository.dart';
import 'package:flutter_app_template/model/repositories/firebase_auth/login_type.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final navigatorKeyProvider = Provider((_) => GlobalKey<NavigatorState>());

enum AuthState {
  /// サインインしていない
  noSignIn,

  /// 匿名認証
  signInWithAnonymously,

  /// サインインしている
  signIn,
}

final authStateProvider = StateProvider<AuthState>((ref) {
  final repository = ref.watch(firebaseAuthRepositoryProvider);
  final loginType = repository.loginType;
  final user = repository.authUser;

  switch (loginType) {
    case null:
      return AuthState.noSignIn;
    case LoginType.email:
      return user!.emailVerified ? AuthState.signIn : AuthState.noSignIn;
    case LoginType.anonymously:
      return AuthState.signInWithAnonymously;
    case LoginType.apple:
    case LoginType.google:
      return AuthState.signIn;
  }
});
