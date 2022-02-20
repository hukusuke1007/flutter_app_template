import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final navigatorKeyProvider = Provider((_) => GlobalKey<NavigatorState>());

enum AuthState {
  noSignIn,
  signInWithAnonymously,
  signIn,
}

final authStateProvider = StateProvider<AuthState>((ref) => AuthState.noSignIn);
