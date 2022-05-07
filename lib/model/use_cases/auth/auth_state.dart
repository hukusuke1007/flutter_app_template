import 'package:flutter_app_template/model/repositories/firebase_auth/firebase_auth_repository.dart';
import 'package:flutter_app_template/model/repositories/firebase_auth/login_type.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum AuthState {
  /// サインインしていない
  noSignIn,

  /// 匿名認証
  signInAnonymously,

  /// サインインしている
  signIn,
}

final authProvider = StateProvider((ref) {
  final repository = ref.watch(firebaseAuthRepositoryProvider);
  final loginType = repository.loginType;
  final user = repository.authUser;

  if (user == null) {
    return AuthState.noSignIn;
  } else if (user.isAnonymous) {
    return AuthState.signInAnonymously;
  } else if (loginType == LoginType.email && !user.emailVerified) {
    // アプリ起動直後にメールアドレスの確認を行なっていない
    return AuthState.noSignIn;
  }
  return AuthState.signIn;
});
