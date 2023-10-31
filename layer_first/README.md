# [LayerFirst] flutter_app_template

## 画面構成

- タブ 1
  - SharedPreferences を用いた カウンター画面
- タブ 2
  - GithubApi を用いた Github Users の一覧画面

## 設計指針

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
    - [widgets/](./lib/presentation/widgets)
  - [app.dart](./lib/app.dart)
  - [main.dart](./lib/main.dart)
