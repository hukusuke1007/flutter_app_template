import 'package:flutter/widgets.dart';
import 'package:share_plus/share_plus.dart';

extension ShareExtension on SharePlus {
  static Future<bool> shareText(BuildContext context, String text) async {
    final box = context.findRenderObject() as RenderBox?;
    if (box == null) {
      return false;
    }
    final result = await SharePlus.instance.share(
      ShareParams(
        text: text,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
      ),
    );
    if (result.status == ShareResultStatus.unavailable) {
      return false;
    }
    return true;
  }

  static Future<bool> shareUri(BuildContext context, Uri uri) async {
    final box = context.findRenderObject() as RenderBox?;
    if (box == null) {
      return false;
    }
    final result = await SharePlus.instance.share(
      ShareParams(
        uri: uri,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
      ),
    );
    if (result.status == ShareResultStatus.unavailable) {
      return false;
    }
    return true;
  }

  static Future<bool> shareFiles(
    BuildContext context,
    List<String> filePaths, {
    String? subject,
    String? text,
  }) async {
    final box = context.findRenderObject() as RenderBox?;
    if (box == null) {
      return false;
    }
    final result = await SharePlus.instance.share(
      ShareParams(
        files: filePaths.map(XFile.new).toList(),
        subject: subject,
        text: text,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
      ),
    );
    if (result.status == ShareResultStatus.unavailable) {
      return false;
    }
    return true;
  }
}
