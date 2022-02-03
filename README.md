# flutter_app_template

## 概要

### 実装済み
- [x] iOS13、Android7 以上
- [x] DDD ライクな設計
- [x] 状態管理は flutter_hooks、riverpod を利用
- [x] Firebase を利用 (FirebaseAuth, Firestore, Functions, FirebaseAnalytics, FirebaseCrashlytics)
- [x] タブ構成のサンプル画面実装
- [x] iOS カメラ、画像のパーミッション許可のplist設定
- [x] その他アプリに必要なライブラリを設定済み
- [x] デバイス向きは縦固定

### やっていないこと
- Android/iOS のFlavor設定
- Android/iOS ローカル通知とプッシュ通知の設定
- Androidのkeystoreの設定（debug, release）
- iPad 対応

## プロジェクト名の変更方法

1. 以下の箇所を変更後のプロジェクト名へ変更。com.example.app から変更したいプロジェクト名にする
   https://github.com/hukusuke1007/flutter_app_template/pull/1/files

2. Firebase の plist を変更し、利用するFirebaseコンソールから匿名認証をONにしてください

3. pub getをしてライブラリを取り込む。
    pubspec.lock内のプラグインのバージョンを見てpubspec.yamlのプラグインのバージョンを指定する（利用するバージョンを固定にするため）

