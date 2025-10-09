import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_info_repository.g.dart';

@Riverpod(keepAlive: true)
DeviceInfoRepository deviceInfoRepository(Ref ref) {
  return DeviceInfoRepository(DeviceInfoPlugin());
}

class DeviceInfoRepository {
  DeviceInfoRepository(this._deviceInfo);

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

  Future<AndroidDeviceInfo> get androidInfo => _deviceInfo.androidInfo;
}
