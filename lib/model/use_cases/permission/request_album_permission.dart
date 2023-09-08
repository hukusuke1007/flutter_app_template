import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'request_album_permission.g.dart';

@riverpod
Future<bool> requestAlbumPermission(RequestAlbumPermissionRef ref) async {
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
}
