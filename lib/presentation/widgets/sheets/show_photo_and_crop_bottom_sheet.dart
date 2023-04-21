import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/crop_image.dart';
import 'show_photo_bottom_sheet.dart';

Future<File?> showPhotoAndCropBottomSheet(
  BuildContext context, {
  String? title,
}) async {
  final result = await showPhotoBottomSheet(context, title: title);
  if (result == PhotoType.camera) {
    final file = await ImagePicker().pickImage(source: ImageSource.camera);
    if (file == null) {
      return null;
    }
    final cropFile = await cropAvatar(file.path);
    return cropFile != null ? File(cropFile.path) : null;
  } else if (result == PhotoType.album) {
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null) {
      return null;
    }
    final cropFile = await cropAvatar(file.path);
    return cropFile != null ? File(cropFile.path) : null;
  }
  return null;
}
