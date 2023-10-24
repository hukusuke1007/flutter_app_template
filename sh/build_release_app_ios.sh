# [iOS] リリース用バイナリ生成コマンド
flutter build ipa --release --dart-define=FLAVOR=prod --target lib/main.dart

# [iOS・難読化] リリース用バイナリ生成コマンド
#flutter build ipa --release --obfuscate --split-debug-info=obfuscate/ios --dart-define=FLAVOR=prod --target lib/main.dart
