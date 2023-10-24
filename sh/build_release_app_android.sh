# [Android] リリース用バイナリ生成コマンド
flutter build appbundle --release --dart-define=FLAVOR=prod --target lib/main.dart

# [Android・難読化] リリース用バイナリ生成コマンド
#flutter build appbundle --release --obfuscate --split-debug-info=obfuscate/android --dart-define=FLAVOR=prod --target lib/main.dart