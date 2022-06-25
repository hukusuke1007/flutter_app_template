import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

final packageInfoRepositoryProvider =
    Provider<PackageInfoRepository>((_) => throw UnimplementedError());

class PackageInfoRepository {
  PackageInfoRepository(this._packageInfo);

  final PackageInfo _packageInfo;
  String get appName => _packageInfo.appName;
  String get appVersion => _packageInfo.version;
  String get packageName => _packageInfo.packageName;
}
