import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../repositories/package_info/package_info_repository.dart';

part 'fetch_app_version.g.dart';

@riverpod
String fetchAppVersion(FetchAppVersionRef ref) {
  return ref.watch(packageInfoRepositoryProvider).appVersion;
}
