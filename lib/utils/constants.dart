// TODO(shohei): 設定する
const androidId = '';
const appleId = '';

/// FirebaseAuthプロバイダーID
const kAppleProviderId = 'apple.com';
const kGoogleProviderId = 'google.com';
const kEmailProviderId = 'password';

/// FirebaseAuthExceptionエラーコード
/// メールアドレスは既に存在する
const kEmailAlreadyInUse = 'email-already-in-use';

/// メールアドレスが正しくない
const kInvalidEmail = 'invalid-email';

/// メールアドレス/パスワードのアカウントが有効でない
/// FirebaseコンソールのAuthタブでメールアドレス認証を有効にする必要がある
const kOperationNotAllowed = 'operation-not-allowed';

/// パスワードが十分に強力でない
const kWeakPassword = 'weak-password';

/// メールアドレス認証情報が提供されていない
/// 事前にメールアドレスでサインインする必要がある
const kMissingEmail = 'missing-email';

/// メールアドレスが有効でない
const kAuthInvalidEmail = 'auth/invalid-email';

/// Androidアプリのインストールが必要
const kAuthMissingAndroidPkgName = 'auth/missing-android-pkg-name';

/// リクエストに続行URLの指定が必要
const kAuthMissingContinueUri = 'auth/missing-continue-uri';

/// App Store IDが提供されている場合、iOSバンドルIDが必要
const kAuthMissingIosBundleId = 'auth/missing-ios-bundle-id';

/// リクエストで提供された続行URLが無効
const kAuthInvalidContinueUri = 'auth/invalid-continue-uri';

/// 続行URLのドメインがホワイトリストに登録されていない
/// Firebaseコンソールでドメインをホワイトリストに登録する必要がある
const kAuthUnauthorizedContinueUri = 'auth/unauthorized-continue-uri';

/// メールアドレスに対応するユーザーが存在しない
const kAuthUserNotFound = 'auth/user-not-found';

/// メールアドレスのパスワードが間違っている
/// または、メールアドレスに対応するユーザーがパスワードを設定していない
const kWrongPassword = 'wrong-password';

/// メールアドレスに対応するユーザーが無効
const kUserDisabled = 'user-disabled';

/// メールアドレスに対応するユーザーが存在しない
const kUserNotFound = 'user-not-found';
