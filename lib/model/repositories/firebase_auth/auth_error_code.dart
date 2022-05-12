/// FirebaseAuthExceptionエラーコード
enum AuthErrorCode {
  /// メールアドレスは既に存在する
  emailAlreadyInUse('email-already-in-use'),

  /// メールアドレスが正しくない
  invalidEmail('invalid-email'),

  /// メールアドレス/パスワードのアカウントが有効でない
  /// FirebaseコンソールのAuthタブでメールアドレス認証を有効にする必要がある
  operationNotAllowed('operation-not-allowed'),

  /// パスワードが十分に強力でない
  weakPassword('weak-password'),

  /// メールアドレス認証情報が提供されていない
  /// 事前にメールアドレスでサインインする必要がある
  missingEmail('weak-password'),

  /// メールアドレスが有効でない
  authInvalidEmail('auth/invalid-email'),

  /// Androidアプリのインストールが必要
  authMissingAndroidPkgName('auth/missing-android-pkg-name'),

  /// リクエストに続行URLの指定が必要
  authMissingContinueUri('auth/missing-continue-uri'),

  /// App Store IDが提供されている場合、iOSバンドルIDが必要
  authMissingIosBundleId('auth/missing-ios-bundle-id'),

  /// リクエストで提供された続行URLが無効
  authInvalidContinueUri('auth/invalid-continue-uri'),

  /// 続行URLのドメインがホワイトリストに登録されていない
  /// Firebaseコンソールでドメインをホワイトリストに登録する必要がある
  authUnauthorizedContinueUri('auth/unauthorized-continue-uri'),

  /// メールアドレスに対応するユーザーが存在しない
  authUserNotFound('auth/user-not-found'),

  /// メールアドレスのパスワードが間違っている
  /// または、メールアドレスに対応するユーザーがパスワードを設定していない
  wrongPassword('wrong-password'),

  /// メールアドレスに対応するユーザーが無効
  userDisabled('user-disabled'),

  /// メールアドレスに対応するユーザーが存在しない
  userNotFound('user-not-found');

  const AuthErrorCode(this.value);
  final String value;
}
