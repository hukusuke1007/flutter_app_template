import 'dart:typed_data';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_template/utils/provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../extensions/context_extension.dart';
import '../../../model/use_cases/permission/request_album_permission.dart';
import '../../../utils/logger.dart';
import '../show_indicator.dart';

final saveImageToMediaFolderProvider = Provider(SaveImageToMediaFolder.new);

class SaveImageToMediaFolder {
  SaveImageToMediaFolder(this._ref);

  final Ref _ref;

  Future<void> call(
    Uint8List imageBytes,
  ) async {
    final status = await _ref.read(requestAlbumPermissionProvider.future);
    final gContext = _ref.read(navigatorKeyProvider).currentContext!;
    if (!status) {
      final result = await showOkAlertDialog(
        context: gContext,
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
      showIndicator(gContext);
      await ImageGallerySaver.saveImage(imageBytes);
      gContext.showSnackBar('画像を保存しました');
    } on Exception catch (e) {
      logger.shout(e);
      gContext.showSnackBar('保存に失敗しました', backgroundColor: Colors.red);
    }
    dismissIndicator(gContext);
  }
}
