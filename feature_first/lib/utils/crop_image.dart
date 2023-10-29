import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

import '../gen/colors.gen.dart';

Future<CroppedFile?> cropAvatar(String path) => _cropImage(
      path,
      cropStyle: CropStyle.circle,
      toolbarTitle: 'プロフィール',
    );

Future<CroppedFile?> cropThumbnail(String path, {String title = 'サムネイル'}) =>
    _cropImage(
      path,
      cropStyle: CropStyle.rectangle,
      toolbarTitle: title,
    );

Future<CroppedFile?> _cropImage(
  String path, {
  required CropStyle cropStyle,
  required String toolbarTitle,
}) async {
  List<CropAspectRatioPreset> getPresets() {
    if (Platform.isAndroid) {
      return [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ];
    } else {
      return [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio5x3,
        CropAspectRatioPreset.ratio5x4,
        CropAspectRatioPreset.ratio7x5,
        CropAspectRatioPreset.ratio16x9,
      ];
    }
  }

  final file = await ImageCropper().cropImage(
    sourcePath: path,
    cropStyle: cropStyle,
    aspectRatioPresets: getPresets(),
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: toolbarTitle,
        toolbarColor: ColorName.primary,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      ),
    ],
  );
  return file;
}
