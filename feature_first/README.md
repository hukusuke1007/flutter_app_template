# [FeatureFirst] flutter_app_template

Flutter + Firebase アプリのスターターキット、新規アプリ開発はこのテンプレートをベースに始める。

| カテゴリ         | 説明                                    |
| ---------------- | --------------------------------------- |
| 状態管理と DI    | flutter_hooks, hooks_riverpod           |
| データモデル     | freezed, equatable                      |
| クラウド DB      | cloud_firestore                         |
| ローカル DB      | shared_preferences                      |
| API クライアント | retrofit                                |
| 画面遷移         | go_router                               |
| Flavor 設定      | --dart-define                           |
| テスト           | flutter_test, integration_test, mockito |

## 画面構成

- タブ 1
  - Hero アニメーションによるモーダル表示
  - SharedPreferences を用いた カウンター画面
  - Firestore を用いた カウンター画面
  - メールアドレス認証のサンプル
  - タイムラインのサンプル
- タブ 2
  - GithubApi を用いた Github Users の一覧画面
- タブ 3
  - Firestore を用いた Memo データ一覧と CRUD
    - データの追加、更新、削除
    - データ一覧の Pull-to-refresh
    - データ一覧の Infinite Scroll Pagination
- タブ 4
  - 設定画面
    - プロフィール 「名前」「誕生日」「画像」の表示と保存
    - アプリ名、パッケージ名、バージョンを表示
    - 株式会社 Never の URL を WebView で表示
    - ログアウト

![screenshot_home](./doc/images/screenshot_home.png)
![screenshot_github](./doc/images/screenshot_github.png)
![screenshot_memo](./doc/images/screenshot_memo.png)
![screenshot_setting](./doc/images/screenshot_setting.png)

![screenshot_sign_in](./doc/images/screenshot_sign_in.png)
![screenshot_sign_up](./doc/images/screenshot_sign_up.png)
![screenshot_change_password](./doc/images/screenshot_change_password.png)
![screenshot_timeline](./doc/images/screenshot_timeline.png)

## 実装済み

- iOS15、Android7 以上で動作
- DDD ライクな FeatureFirst 構成で設計
- Firebase を利用 (FirebaseAuth, Firestore, Functions, FirebaseAnalytics, FirebaseCrashlytics)
- retrofit を用いた サンプルコード
- 画面遷移は go_router（ShellRoute は未対応）
- ボトムナビゲーション構成のサンプル画面
- 画像選択・保存
- カメラ、画像のパーミッション設定
- 起動時に匿名認証でログイン
- ダークモード対応
- デバイス向きは縦固定
- 静的解析導入
- Android/iOS の Flavor 設定
- iOS 日本語デフォルト
- MethodChannel と EventChannel のサンプルコード
  - Android は Talkback、iOS は VoiceOver の設定状態の表示
- その他アプリに必要なライブラリを設定済み
- fvm, asdf
- Unit tests（オフラインテスト）
- Widget tests（オフラインテスト）
- Integration tests（E2E テスト）

## やっていないこと

- Android/iOS ローカル通知とプッシュ通知の設定
- Android の keystore の設定（debug, release）
- ローカライズ対応
- dartdoc
- fastlane
- テストでスクリーンショット撮影

## 設計指針

### ディレクトリ構成

- [lib/](./lib)
  - [core/](./lib/core)
    - [converters/](./lib/core/converters)
    - [custom_hooks/](./lib/core/custom_hooks)
    - [entities/](./lib/core/entities)
    - [exceptions/](./lib/core/exceptions)
    - [extensions/](./lib/core/extensions)
    - [repositories/](./lib/core/repositories)
    - [res/](./lib/core/res)
    - [router/](./lib/core/router)
    - [use_cases/](./lib/core/use_cases)
    - [utils/](./lib/core/utils)
    - [widgets/](./lib/core/widgets)
  - [features/](./lib/features)
    - [app_wrapper/](./lib/features/app_wrapper)
    - [authentication/](./lib/features/authentication)
    - [error/](./lib/features/error)
    - [counter/](./lib/features/counter)
    - [github_users/](./lib/features/github_users)
    - [home/](./lib/features/home)
    - [memo/](./lib/features/memo)
    - [setting/](./lib/features/setting)
    - [start_up/](./lib/features/start_up)
    - [timeline/](./lib/features/timeline)
  - [app.dart](./lib/app.dart)
  - [main.dart](./lib/main.dart)

### Flavor

| 環境 | パッケージ名        | アプリ名           |
| ---- | ------------------- | ------------------ |
| 開発 | com.example.app.dev | dev.テンプレアプリ |
| 本番 | com.example.app     | 　テンプレアプリ   |

### 実行コマンド

- 開発

  ```sh
  flutter run --debug --dart-define=FLAVOR=dev
  ```

- 本番

  ```sh
  flutter run --debug --dart-define=FLAVOR=prod
  ```

Android Studio から実行する場合は、以下のように Run Configurations を設定する。

- dev 環境でビルドする場合

![dev](./doc/images/run_configuration_debug_dev.png)

- prod 環境でビルドする場合

![prod](./doc/images/run_configuration_debug_prod.png)

### Mason を使って Feature ディレクトリを作成する

mason に登録されている brick を取り込む

```sh
mason get
```

feature を実行してディレクトリを作成する

```sh
mason make feature
```

作成したディレクトリを[lib/features](lib/features/)へ移動して実装する

### リリースビルド

- Android

  ```sh
  # dev
  flutter build appbundle --release --dart-define=FLAVOR=dev

  # prod
  flutter build appbundle --release --dart-define=FLAVOR=prod
  ```

- iOS

  ```sh
  # dev
  flutter build ipa --release --dart-define=FLAVOR=dev

  # prod
  flutter build ipa --release --dart-define=FLAVOR=prod
  ```

## テスト

### Unit tests

```sh
# Run all tests
flutter test

# Run target test
flutter test test/features/github_users/repositories/github_api_repository_test.dart
```

ドキュメント

- [Testing Flutter apps: Unit tests](https://docs.flutter.dev/testing#unit-tests)

### Widget tests

```sh
# Run all tests
flutter test

# Run target test
flutter test test/features/github_users/pages/github_users_page_test.dart
```

ドキュメント

- [Testing Flutter apps: Widget tests](https://docs.flutter.dev/testing#widget-tests)

### Integration tests

実機・シミュレータを起動させるので、実行コマンドに flavor 設定の json を指定してください。

```sh
# Run all tests
flutter test --dart-define=FLAVOR=dev integration_test

# Run target test
flutter test --dart-define=FLAVOR=dev integration_test/features/github_users/pages/github_users_page_test.dart
```

ドキュメント

- [Testing Flutter apps: Integration tests](https://docs.flutter.dev/testing#integration-tests)

### モック

[mockito](https://pub.dev/packages/mockito)を利用しています。モックの DI は[Riverpod](https://riverpod.dev/)の overrides を利用しています。

ドキュメント

- [Mock dependencies using Mockito](https://docs.flutter.dev/cookbook/testing/unit/mocking)

- [Riverpod Testing](https://docs-v2.riverpod.dev/docs/cookbooks/testing)

- [How to Unit Test AsyncNotifier Subclasses with Riverpod 2.0 in Flutter](https://codewithandrea.com/articles/unit-test-async-notifier-riverpod/)

## 新規プロジェクトへの移行方法

1. git clone で取り込み、作業用ディレクトリへコピーする

   ```sh
   git clone https://github.com/hukusuke1007/flutter_app_template.git
   cp -rf feature_first/ [作業用ディレクトリのパス]
   cd [作業用ディレクトリのパス]
   ```

2. 取り込み後、作業用ディレクトリ内の`.git`を削除する

   ```sh
   rm -rf .git
   ```

3. 変更したいアプリ名、パッケージ名、プロジェクト名 にする。以下の通り手動で修正するか、[change_app_package_name](https://pub.dev/packages/change_app_package_name)を使って自動で修正する。

   - アプリ名を変更する

     - iOS:

       `$(APP_NAME_PREFIX)`はそのままで、それ以外を変更する

       - [info.plist - CFBundleDisplayName](./ios/Runner/Info.plist#L16)
       - [info.plist - CFBundleName](./ios/Runner/Info.plist#L24)

     - Android:

       `android/app/build.gradle`

       - [resValue](./android/app/build.gradle#L84)

   - `com.example.app` のパッケージ名を変更する

     - iOS:

       `Xcode > Runner > TARGETS Runner > Build Settings` の `Product Bundle Identifier` を変更。
       Debug, Profile, Release の全てを変更する。`$(APP_ID_SUFFIX)`はそのままにしてください。
       ![dev](./doc/images/product_bundle_identifier.png)

     - Android:

       - android/app/build.gradle
         - [namespace](./android/app/build.gradle#L57)
         - [applicationId](./android/app/build.gradle#L75)
       - AndroidManifest.xml - package

         - [main](./android/app/src/main/AndroidManifest.xml#L2)
         - [debug](./android/app/src/debug/AndroidManifest.xml#L2)
         - [profile](./android/app/src/profile/AndroidManifest.xml#L2)

       - MainActivity.kt

         - [package](./android/app/src/main/kotlin/com/example/app/MainActivity.kt#L1)

       - ScreenReaderPlugin.kt

         - [package1](./android/app/src/main/kotlin/com/example/app/ScreenReaderPlugin.kt#L1)
         - [package2](./android/app/src/main/kotlin/com/example/app/ScreenReaderPlugin.kt#L15)
         - [package3](./android/app/src/main/kotlin/com/example/app/ScreenReaderPlugin.kt#L25)

       - kotlin 配下のディレクトリ名を変更する

         （例）`com.example.app` から `com.never.jp` へ変更した場合

         ```md
         変更前: android/app/src/main/kotlin/com/example/app
         変更後: android/app/src/main/kotlin/com/never/jp
         ```

   - プロジェクト名を変更する
     - [pubspec.yaml の name](./pubspec.yaml#L1)

4. 新しい Firebase プロジェクトを構築する。
   開発環境、本番環境の 2 種類用意する。なお、開発環境のパッケージ名の末尾は必ず `.dev` を付与する。

   - [Firebase の構築方法](https://firebase.flutter.dev/docs/overview)

   以下の手順で Firebase の設定を行います：

   1. flutterfire CLI をインストールして環境ごとに `firebase_options.dart` を生成する

      ```sh
      # flutterfire CLI をインストール
      dart pub global activate flutterfire_cli

      # 開発環境用の firebase_options.dart を生成
      flutterfire configure --project=your-dev-project-id --out=lib/core/firebase/dev/firebase_options.dart

      # 本番環境用の firebase_options.dart を生成
      flutterfire configure --project=your-prod-project-id --out=lib/core/firebase/prod/firebase_options.dart
      ```

   2. 構築した Firebase の設定ファイルを以下の場所へ設置する

      - Android

        ```md
        # 開発環境

        android/app/src/dev/google-services.json

        # 本番環境

        android/app/src/prod/google-services.json
        ```

      - iOS

        ```md
        # 開発環境

        ios/dev/GoogleService-Info.plist

        # 本番環境

        ios/prod/GoogleService-Info.plist
        ```

5. Firebase コンソールから匿名認証を 開発環境、本番環境共に ON にする

6. Flutter のライブラリを取り込む。 pub get を実行する。
   利用するバージョンを固定にするため、[pubspec.lock](./pubspec.lock) 内のプラグインのバージョンを見て [pubspec.yaml](./pubspec.yaml) のプラグインのバージョンを指定する。

7. [実行コマンド](#実行コマンド)を用いて動作確認する。

8. 問題なければ新しい git repository を作成して本プロジェクトをプッシュする。

9. あとは良しなに使わないプラグインやコードを削除して開発を進めてください。

### 注意

タイムライン機能を確認するためには、Firestore の`posts`コレクションの index を設定してください。

![firestore_posts_index](./doc/images/firestore_posts_index.png)
