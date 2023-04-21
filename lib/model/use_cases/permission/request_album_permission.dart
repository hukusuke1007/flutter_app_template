import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final requestAlbumPermissionProvider =
    FutureProvider.autoDispose<bool>((ref) async {
  final status = await Future(() async {
    if (Platform.isAndroid) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      if (androidInfo.version.sdkInt >= 33) {
        return Permission.photos.request();
      } else {
        return Permission.storage.request();
      }
    } else {
      return Permission.photos.request();
    }
  });
  return status.isGranted;
});
