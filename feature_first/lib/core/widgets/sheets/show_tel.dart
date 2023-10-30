import 'dart:io';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

var _isTapped = false;

Future<void> showTel(BuildContext context, String phoneNumber) async {
  if (Platform.isAndroid) {
    final result = await showModalActionSheet<bool>(
      context: context,
      actions: [
        SheetAction<bool>(label: '$phoneNumber に電話', key: true),
        const SheetAction<bool>(label: 'キャンセル', key: false),
      ],
      cancelLabel: 'キャンセル',
    );
    if (result == true) {
      await launchUrl(Uri.parse('tel:$phoneNumber'));
    }
  } else {
    if (_isTapped) {
      return;
    }
    _isTapped = true;
    await launchUrl(Uri.parse('tel:$phoneNumber'));
    _isTapped = false;
  }
}
