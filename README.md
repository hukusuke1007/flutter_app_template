# flutter_app_template

## 概要

Flutter + Firebase アプリの雛形

### 実装済み

- iOS13、Android7 以上
- DDD ライクな設計
- 状態管理は flutter_hooks、riverpod を利用
- Firebase を利用 (FirebaseAuth, Firestore, Functions, FirebaseAnalytics, FirebaseCrashlytics)
- タブ構成のサンプル画面実装
- iOS カメラ、画像のパーミッション許可の plist 設定
- その他アプリに必要なライブラリを設定済み
- デバイス向きは縦固定

### やっていないこと

- Android/iOS の Flavor 設定
- Android/iOS ローカル通知とプッシュ通知の設定
- Android の keystore の設定（debug, release）
- iPad 対応

## 新規プロジェクトへの移行方法

1. 以下の箇所を変更後のプロジェクト名へ変更。com.example.app から変更したいプロジェクト名にする
   https://github.com/hukusuke1007/flutter_app_template/pull/1/files

2. Firebase の 設定ファイル を変更する。必ず新規プロジェクトの設定ファイルを利用する。設定ファイルは以下の場所で入れ替える。

```
android/app/google-services.json
ios/Runner/GoogleService-Info.plist
```

3. 利用する Firebase コンソールから匿名認証を ON にする

4. pub get をしてライブラリを取り込む。pubspec.lock 内のプラグインのバージョンを見て pubspec.yaml のプラグインのバージョンを指定する（利用するバージョンを固定にするため）
