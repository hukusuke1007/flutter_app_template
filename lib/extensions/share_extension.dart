import 'package:flutter/widgets.dart';
import 'package:share_plus/share_plus.dart';

extension ShareExtension on Share {
  static Future<bool> shareText(BuildContext context, String text) async {
    final box = context.findRenderObject() as RenderBox?;
    if (box == null) {
      return false;
    }
    await Share.share(
      text,
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
    );
    return true;
  }
}
