import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'package_info_repository.g.dart';

@Riverpod(keepAlive: true)
PackageInfoRepository packageInfoRepository(Ref ref) {
  throw UnimplementedError();
}

class PackageInfoRepository {
  PackageInfoRepository(this._packageInfo);

  final PackageInfo _packageInfo;
  String get appName => _packageInfo.appName;
  String get appVersion => _packageInfo.version;
  String get packageName => _packageInfo.packageName;
}
