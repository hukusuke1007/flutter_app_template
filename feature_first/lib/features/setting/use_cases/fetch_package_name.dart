import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/repositories/package_info/package_info_repository.dart';

part 'fetch_package_name.g.dart';

@riverpod
String fetchPackageName(Ref ref) {
  return ref.watch(packageInfoRepositoryProvider).packageName;
}
