# Automatic code generation.
run_build_runner:
	dart run build_runner build --delete-conflicting-outputs

# Monitor and automatically generate code.
watch_build_runner:
	dart run build_runner watch

run_slang:
	dart run slang

watch_slang:
	dart run slang watch

# Pub get.
pub_get:
	flutter pub get
# Create App.
create_app:
	flutter create --org app.yourdomain --platforms android,ios,macos,web -i swift -a kotlin .

# Create icon.
create_icon:
	dart run flutter_launcher_icons:main

# Create icon.
create_native_splash:
	flutter pub run flutter_native_splash:create

# flutterfire
flutterfire_configure:
	flutterfire configure --ios-bundle-id=app.yourdomain.sample --android-package-name=app.yourdomain.sample --project=sample-prod

flutterfire_configure_dev:
	flutterfire configure --ios-bundle-id=app.yourdomain.sample.dev --android-package-name=app.yourdomain.sample.dev --project=sample-dev

# Change package name.
package_rename:
	dart run package_rename

# [Flavor is development] Run.
run_dev:
	flutter run --dart-define=FLAVOR=dev --target lib/main.dart

# [Flavor is production] Run.
run_prod:
	flutter run --dart-define=FLAVOR=prod --target lib/main.dart

# [Android] Release build.
release_build_android:
	flutter build appbundle --release --dart-define=FLAVOR=prod --target lib/main.dart

# [Android + Obfuscate] Release build.
release_build_obfuscate_android:
	flutter build appbundle --release --obfuscate --split-debug-info=obfuscate/android --dart-define=FLAVOR=prod --target lib/main.dart

# [iOS] Release build.
release_build_ios:
	flutter build ipa --release --dart-define=FLAVOR=prod --target lib/main.dart

# [iOS + Obfuscate] Release build.
release_build_obfuscate_ios:
	flutter build ipa --release --obfuscate --split-debug-info=obfuscate/ios --dart-define=FLAVOR=prod --target lib/main.dart

# Test with coverage.
flutter_test_c:
	flutter test --coverage

# Masonのbrickを取得する
mason_get:
	mason get

# Masonのbricksのアップグレードする
mason_upgrade:
	mason upgrade

# Masonで新しいfeatureディレクトリを作成する
mason_make_feature:
	mason make feature
