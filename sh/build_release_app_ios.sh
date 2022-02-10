# [iOS] リリース用バイナリ生成コマンド
flutter build ipa --export-options-plist=ExportOptions.plist --release --dart-define=FLAVOR=prod --target lib/main.dart
