# [LayerFirst] flutter_app_template

## 画面構成

- タブ 1
    - Hero アニメーションによるモーダル表示
    - SharedPreferences を用いた カウンター画面
    - Firestore を用いた カウンター画面
    - メールアドレス認証のサンプル
    - タイムラインのサンプル
- タブ 2
    - GithubApi を用いた Github Users の一覧画面


## 設計指針

[こちらの資料](https://docs.google.com/presentation/d/19XERQBG-aWWD7R5NEJCyS8VXSeUL9KTENOe0ChYz_1M)にまとめました。

### ディレクトリ構成

- [lib/](./lib)
    - [exceptions/](./lib/exceptions)
    - [extensions/](./lib/extensions)
    - [model/](./lib/model)
      - [entities/](./lib/model/entities)
      - [repositories/](./lib/model/repositories)
      - [use_cases/](./lib/model/use_cases)
    - [presentation/](lib/presentation)
      - [custom_hooks/](./lib/presentation/custom_hooks)
      - [pages/](./lib/presentation/pages)
      - [res/](./lib/presentation/res)
      - [res/](./lib/presentation/widgets)
    - [app.dart](./lib/app.dart)
    - [main.dart](./lib/main.dart)
