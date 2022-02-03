# [iOS] リリース用バイナリ生成コマンド
flutter build ipa --export-options-plist=ExportOptions.plist --release --flavor production --dart-define=FLAVOR=prd --target lib/main.dart
