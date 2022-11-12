import 'dart:io';

import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final deviceInfoRepositoryProvider = Provider<DeviceInfoRepository>(
  (_) => DeviceInfoRepository(
    DeviceInfoPlugin(),
    const AndroidId(),
  ),
);

class DeviceInfoRepository {
  DeviceInfoRepository(
    this._deviceInfo,
    this._androidId,
  );

  final DeviceInfoPlugin _deviceInfo;
  final AndroidId _androidId;

  Future<String?> get deviceId async {
    if (Platform.isIOS) {
      final info = await _deviceInfo.iosInfo;
      return info.identifierForVendor;
    } else if (Platform.isAndroid) {
      final androidId = await _androidId.getId();
      return androidId;
    }
    return null;
  }
}
