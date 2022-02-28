import 'dart:async';
import 'dart:io';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../utils/vibration.dart';

enum PhotoType {
  camera,
  album,
}

Future<PhotoType?> showPhotoBottomSheet(
  BuildContext context, {
  String? title,
}) async {
  unawaited(Vibration.select());
  final result = await showModalActionSheet<int>(
    context: context,
    title: title,
    actions: const [
      SheetAction<int>(
        label: 'カメラで撮影する',
        key: 0,
        icon: Icons.camera_alt,
      ),
      SheetAction<int>(
        label: 'アルバムから選択する',
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
        context: context,
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
    final status = await Future(
      () => Platform.isIOS
          ? Permission.photos.request()
          : Permission.storage.request(),
    );
    if (!status.isGranted) {
      final result = await showOkAlertDialog(
        context: context,
        title: 'アルバムのパーミッション',
        message: 'アプリの設定画面よりアルバムを許可してください。',
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
