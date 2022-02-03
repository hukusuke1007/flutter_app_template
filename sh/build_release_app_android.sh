# [Android] リリース用バイナリ生成コマンド
# 開発環境によって使い分ける
flutter build appbundle --release --flavor production --dart-define=FLAVOR=prd --target lib/main.dart