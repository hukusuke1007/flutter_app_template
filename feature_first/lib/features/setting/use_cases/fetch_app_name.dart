import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/repositories/package_info/package_info_repository.dart';

part 'fetch_app_name.g.dart';

@riverpod
String fetchAppName(FetchAppNameRef ref) {
  return ref.watch(packageInfoRepositoryProvider).appName;
}
