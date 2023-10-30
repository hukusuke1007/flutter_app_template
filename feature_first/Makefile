# コードを自動生成する
run_build_runner:
	dart run build_runner build

# コードを監視して自動生成する
watch_build_runner:
	dart run build_runner watch

# アイコンを作成
create_icon:
	flutter pub run flutter_launcher_icons:main

# [Android] リリースビルド
release_build_android:
	flutter build appbundle --release --dart-define=FLAVOR=prod --target lib/main.dart

# [Android + 難読化] リリースビルド
release_build_obfuscate_android:
	flutter build appbundle --release --obfuscate --split-debug-info=obfuscate/android --dart-define=FLAVOR=prod --target lib/main.dart

# [iOS] リリースビルド
release_build_ios:
	flutter build ipa --release --dart-define=FLAVOR=prod --target lib/main.dart

# [iOS + 難読化] リリースビルド
release_build_obfuscate_ios:
	flutter build ipa --release --obfuscate --split-debug-info=obfuscate/ios --dart-define=FLAVOR=prod --target lib/main.dart

# Masonのbrickを取得する
mason_get:
	mason get

# Masonで新しいfeatureディレクトリを作成する
mason_make_feature:
	mason make feature