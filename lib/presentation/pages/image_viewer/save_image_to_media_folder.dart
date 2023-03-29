import 'dart:io';
import 'dart:typed_data';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../extensions/context_extension.dart';
import '../../../utils/logger.dart';
import '../../widgets/show_indicator.dart';

Future<void> saveImageToMediaFolder(
  BuildContext context,
  Uint8List imageBytes,
) async {
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
  if (!status.isGranted) {
    final result = await showOkAlertDialog(
      context: context,
      title: '写真のパーミッション',
      message: 'アプリの設定画面より写真のアクセスを許可してください。',
      okLabel: '設定画面を開く',
    );
    if (result == OkCancelResult.ok) {
      await openAppSettings();
    }
    return;
  }

  try {
    showIndicator(context);
    await ImageGallerySaver.saveImage(imageBytes);
    context.showSnackBar('画像を保存しました');
  } on Exception catch (e) {
    logger.shout(e);
    context.showSnackBar('保存に失敗しました', backgroundColor: Colors.red);
  }
  dismissIndicator(context);
}
