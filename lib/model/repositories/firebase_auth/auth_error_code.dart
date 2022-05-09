/// FirebaseAuthExceptionエラーコード
class AuthErrorCode {
  AuthErrorCode._();

  /// メールアドレスは既に存在する
  static const String emailAlreadyInUse = 'email-already-in-use';

  /// メールアドレスが正しくない
  static const String invalidEmail = 'invalid-email';

  /// メールアドレス/パスワードのアカウントが有効でない
  /// FirebaseコンソールのAuthタブでメールアドレス認証を有効にする必要がある
  static const String operationNotAllowed = 'operation-not-allowed';

  /// パスワードが十分に強力でない
  static const String weakPassword = 'weak-password';

  /// メールアドレス認証情報が提供されていない
  /// 事前にメールアドレスでサインインする必要がある
  static const String missingEmail = 'missing-email';

  /// メールアドレスが有効でない
  static const String authInvalidEmail = 'auth/invalid-email';

  /// Androidアプリのインストールが必要
  static const String authMissingAndroidPkgName = 'auth/missing-android-pkg-name';

  /// リクエストに続行URLの指定が必要
  static const String authMissingContinueUri = 'auth/missing-continue-uri';

  /// App Store IDが提供されている場合、iOSバンドルIDが必要
  static const String authMissingIosBundleId = 'auth/missing-ios-bundle-id';

  /// リクエストで提供された続行URLが無効
  static const String authInvalidContinueUri = 'auth/invalid-continue-uri';

  /// 続行URLのドメインがホワイトリストに登録されていない
  /// Firebaseコンソールでドメインをホワイトリストに登録する必要がある
  static const String authUnauthorizedContinueUri = 'auth/unauthorized-continue-uri';

  /// メールアドレスに対応するユーザーが存在しない
  static const String authUserNotFound = 'auth/user-not-found';

  /// メールアドレスのパスワードが間違っている
  /// または、メールアドレスに対応するユーザーがパスワードを設定していない
  static const String wrongPassword = 'wrong-password';

  /// メールアドレスに対応するユーザーが無効
  static const String userDisabled = 'user-disabled';

  /// メールアドレスに対応するユーザーが存在しない
  static const String userNotFound = 'user-not-found';
}
