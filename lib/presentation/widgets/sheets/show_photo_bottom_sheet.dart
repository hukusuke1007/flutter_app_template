import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_template/utils/provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../model/use_cases/permission/request_album_permission.dart';
import '../../../utils/vibration.dart';

enum PhotoType {
  camera,
  album,
}

Future<PhotoType?> showPhotoBottomSheet(
  WidgetRef ref, {
  String? title,
}) async {
  unawaited(Vibration.select());
  final gContext = ref.watch(navigatorKeyProvider).currentContext!;
  final result = await showModalActionSheet<int>(
    context: gContext,
    title: title,
    actions: const [
      SheetAction<int>(
        label: 'カメラで撮影する',
        key: 0,
        icon: Icons.camera_alt,
      ),
      SheetAction<int>(
        label: '写真から選択する',
        key: 1,
        icon: Icons.photo,
      ),
    ],
    cancelLabel: '閉じる',
  );

  if (result == 0) {
    final status = await Permission.camera.request();
    if (!status.isGranted) {
      final result = await showOkAlertDialog(
        context: gContext,
        title: 'カメラのパーミッション',
        message: 'アプリの設定画面よりカメラを許可してください。',
        okLabel: '設定画面を開く',
      );
      if (result == OkCancelResult.ok) {
        await openAppSettings();
      }
    } else {
      return PhotoType.camera;
    }
  } else if (result == 1) {
    final isGranted = await ref.read(requestAlbumPermissionProvider.future);
    if (!isGranted) {
      final result = await showOkAlertDialog(
        context: gContext,
        title: '写真のパーミッション',
        message: 'アプリの設定画面より写真のアクセスを許可してください。',
        okLabel: '設定画面を開く',
      );
      if (result == OkCancelResult.ok) {
        await openAppSettings();
      }
    } else {
      return PhotoType.album;
    }
  }
  return null;
}
