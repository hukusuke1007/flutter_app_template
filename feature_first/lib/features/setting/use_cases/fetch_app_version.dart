import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/repositories/package_info/package_info_repository.dart';

part 'fetch_app_version.g.dart';

@riverpod
String fetchAppVersion(Ref ref) {
  return ref.watch(packageInfoRepositoryProvider).appVersion;
}
