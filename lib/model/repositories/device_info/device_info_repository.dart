import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final deviceInfoRepositoryProvider = Provider<DeviceInfoRepository>(
  (_) => DeviceInfoRepository(DeviceInfoPlugin()),
);

class DeviceInfoRepository {
  DeviceInfoRepository(
    this._deviceInfo,
  );

  final DeviceInfoPlugin _deviceInfo;

  Future<String?> get deviceId async {
    if (Platform.isIOS) {
      final info = await _deviceInfo.iosInfo;
      return info.identifierForVendor;
    } else if (Platform.isAndroid) {
      /// device_info_plusではAndroidの端末IDは取得できない
      /// android_idパッケージを使えば取得できるがReleaseビルドで落ちるため推奨しない
      /// 本プロジェクトではnullを返却する
    }
    return null;
  }
}
