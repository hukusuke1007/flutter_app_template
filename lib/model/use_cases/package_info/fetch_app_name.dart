import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../repositories/package_info/package_info_repository.dart';

final fetchAppNameProvider =
    Provider<String>((ref) => ref.watch(packageInfoRepositoryProvider).appName);
