import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../repositories/firebase_auth/firebase_auth_repository.dart';
import '../../repositories/firebase_auth/login_type.dart';

part 'auth_state_controller.g.dart';

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

@Riverpod(keepAlive: true, dependencies: [firebaseAuthRepository])
class AuthStateController extends _$AuthStateController {
  @override
  AuthState build() {
    final repository = ref.watch(firebaseAuthRepositoryProvider);
    final loginType = repository.loginType;
    return switch (loginType) {
      null => AuthState.noSignIn,
      LoginType.anonymously => AuthState.signInWithAnonymously,
      LoginType.email ||
      LoginType.apple ||
      LoginType.google =>
        AuthState.signIn,
    };
  }

  void update(AuthState authState) {
    state = authState;
  }
}
