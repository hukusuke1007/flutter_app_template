# flutter_app_template

Flutter + Firebase アプリの雛形

| カテゴリ      | 説明                          |
| ------------- | ----------------------------- |
| 状態管理と DI | flutter_hooks, hooks_riverpod |
| データモデル  | freezed                       |
| クラウド DB   | cloud_firestore               |
| ローカル DB   | shared_preferences            |

### 環境

Flutter Stable 2.10.0

### 画面構成

- タブ 1
  - SharedPreferences を用いた カウンター
- タブ 2
  - Firestore を用いた カウンター
- タブ 3
  - Firestore を用いた Memo データ一覧と CRUD
- タブ 4
  - アプリバージョンを表示

### 実装済み

- iOS13、Android7 以上で動作
- DDD ライクな設計で構築
- Firebase を利用 (FirebaseAuth, Firestore, Functions, FirebaseAnalytics, FirebaseCrashlytics)
- ボトムナビゲーション構成のサンプル画面
- iOS カメラ、画像のパーミッション許可の plist 設定
- 起動時に匿名認証でログイン
- ダークモード対応
- デバイス向きは縦固定
- 静的解析導入
- その他アプリに必要なライブラリを設定済み
- device_preview 導入

### やっていないこと

- Android/iOS の Flavor 設定
- Android/iOS ローカル通知とプッシュ通知の設定
- Android の keystore の設定（debug, release）
- ローカライズ対応
- iPad 対応
- ユニットテスト
- UI テスト
- dartdoc

## 設計指針

[こちらの資料](https://docs.google.com/presentation/d/19XERQBG-aWWD7R5NEJCyS8VXSeUL9KTENOe0ChYz_1M)にまとめました。

### ディレクトリ構造

- [lib/](./lib)
  - [extensions/](./lib/extensions)
  - [gen/](./lib/gen)
  - [model/](./lib/model)
    - [converters/](./lib/model/converters)
    - [entities/](./lib/model/entities)
    - [exceptions/](./lib/model/exceptions)
    - [repositories/](./lib/model/repositories)
    - [use_cases/](./lib/model/use_cases)
  - [presentation/](./lib/presentation)
    - [pages/](./lib/presentation/pages)
    - [res/](./lib/presentation/res)
    - [widgets/](./lib/presentation/widgets)
  - [main.dart](./lib/main.dart)

## 新規プロジェクトへの移行方法

1. git clone で取り込む

   ```
   git clone https://github.com/hukusuke1007/flutter_app_template.git
   ```

2. 取り込んだら .git を削除する

   ```
   rm -rf .git
   ```

3. `com.example.app` から変更したいプロジェクト名にする。以下の PR を参考に変更する

   - https://github.com/hukusuke1007/flutter_app_template/pull/1/files

   また、以下も新しいプロジェクトの情報へ変更する

   - アプリ名を変更する
     - iOS: info.plist => [CFBundleDisplayName](https://github.com/hukusuke1007/flutter_app_template/blob/main/ios/Runner/Info.plist#L16)
     - Android: strings.xml => [app_name](https://github.com/hukusuke1007/flutter_app_template/blob/main/android/app/src/main/res/values/strings.xml#L3)
   - プロジェクト名を変更する
     - ディレクトリ名
     - [pubspec.yaml の name](https://github.com/hukusuke1007/flutter_app_template/blob/main/pubspec.yaml#L1)

4. 新しい Firebase プロジェクトを構築する

   - [Firebase の構築方法](https://firebase.flutter.dev/docs/overview)

   構築した Firebase の設定ファイル（.json と.plist）を以下の場所へ設置する

   ```
   android/app/google-services.json
   ios/Runner/GoogleService-Info.plist
   ```

5. 利用する Firebase の コンソールから匿名認証を ON にする

6. flutter のライブラリを取り込む。 pub get を実行する。利用するバージョンを固定にするため、pubspec.lock 内のプラグインのバージョンを見て pubspec.yaml のプラグインのバージョンを指定する。

7. ビルドして動作確認する

8. 問題なければ新しい git repository を作成して本プロジェクトをプッシュする。

9. あとは良しなに使わないプラグインやコードを削除して開発を進めてください。
