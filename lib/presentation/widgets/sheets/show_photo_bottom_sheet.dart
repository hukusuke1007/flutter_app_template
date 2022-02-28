import 'dart:async';
import 'dart:io';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../utils/vibration.dart';
import '../wrapped_image_cropper.dart';

Future<File?> showPhotoAndCropBottomSheet(BuildContext context) async {
  unawaited(Vibration.select());
  final result = await showPhotoBottomSheet(context, title: 'プロフィール画像を変更します。');
  if (result == PhotoType.camera) {
    final file = await ImagePicker().pickImage(source: ImageSource.camera);
    if (file == null) {
      return null;
    }
    final cropFile = await cropAvatar(file.path);
    return cropFile;
  } else if (result == PhotoType.album) {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null) {
      return null;
    }
    final cropFile = await cropAvatar(file.path);
    return cropFile;
  }
  return null;
}

enum PhotoType {
  camera,
  album,
}

Future<PhotoType?> showPhotoBottomSheet(
  BuildContext context, {
  required String title,
}) async {
  return showModalBottomSheet<PhotoType?>(
    context: context,
    builder: (context) {
      return SafeArea(
        child: SizedBox(
          height: 160,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
                            .copyWith(top: 16),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('カメラで撮影する'),
                  onTap: () async {
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
                      return;
                    }
                    Navigator.of(context).pop(PhotoType.camera);
                  },
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Divider(height: 1),
                ),
                ListTile(
                  leading: const Icon(Icons.photo),
                  title: const Text('アルバムから選択する'),
                  onTap: () async {
                    final status = await Permission.photos.request();
                    if (!status.isGranted) {
                      final result = await showOkAlertDialog(
                        context: context,
                        title: '写真選択のパーミッション',
                        message: 'アプリの設定画面より写真選択を許可してください。',
                        okLabel: '設定画面を開く',
                      );
                      if (result == OkCancelResult.ok) {
                        await openAppSettings();
                      }
                      return;
                    }
                    Navigator.of(context).pop(PhotoType.album);
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
