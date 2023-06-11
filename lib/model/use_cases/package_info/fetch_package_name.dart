import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../repositories/package_info/package_info_repository.dart';

final fetchPackageNameProvider = Provider<String>(
  (ref) => ref.watch(packageInfoRepositoryProvider).packageName,
);
