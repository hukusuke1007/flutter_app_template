import 'dart:io';

import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../repositories/device_info/device_info_repository.dart';

part 'request_album_permission.g.dart';

@Riverpod(keepAlive: true)
RequestAlbumPermission requestAlbumPermission(Ref ref) {
  return RequestAlbumPermission(ref);
}

class RequestAlbumPermission {
  RequestAlbumPermission(this._ref);

  final Ref _ref;

  Future<bool> call() async {
    final status = await Future(() async {
      if (Platform.isAndroid) {
        final androidInfo = await _ref
            .read(deviceInfoRepositoryProvider)
            .androidInfo;
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
}
