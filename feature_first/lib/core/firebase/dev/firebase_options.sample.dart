// このファイルはCIや初期セットアップ用のプレースホルダーです。
//
// 実際に利用する際は FlutterFire CLI で生成した firebase_options.dart を
// このディレクトリに配置してください（Makefileの `make flutterfire_configure_dev`）。
// 生成される firebase_options.dart は .gitignore 済みでコミットされません。
//
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static FirebaseOptions get android => const FirebaseOptions(
    apiKey: 'dummy-android-api-key',
    appId: '1:000000000000:android:0000000000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'dummy-dev',
    storageBucket: 'dummy-dev.firebasestorage.app',
  );

  static FirebaseOptions get ios => const FirebaseOptions(
    apiKey: 'dummy-ios-api-key',
    appId: '1:000000000000:ios:0000000000000000000000',
    messagingSenderId: '000000000000',
    projectId: 'dummy-dev',
    storageBucket: 'dummy-dev.firebasestorage.app',
    iosClientId: '000000000000-dummy.apps.googleusercontent.com',
    iosBundleId: 'com.example.app.dev',
  );
}
