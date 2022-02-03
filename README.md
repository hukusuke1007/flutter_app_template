# flutter_app_template

- [x] iOS13、Android7 以上
- [x] DDD ライクな設計
- [x] 状態管理は flutter_hooks、riverpod を利用
- [x] Firebase を利用
- [x] iPad 未対応
- [x] その他アプリに必要なライブラリを設定済み

## プロジェクト名の変更方法

1. 以下の箇所を変更後のプロジェクト名へ変更。com.example.app から変更したいプロジェクト名にする
   https://github.com/hukusuke1007/flutter_app_template/pull/1/files

2. Firebase の plist を変更

3. pub getをしてライブラリを取り込む。
    pubspec.lock内のプラグインのバージョンを見てpubspec.yamlのプラグインのバージョンを指定する（利用するバージョンを固定にするため）
