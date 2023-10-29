import 'package:flutter/services.dart' as service;

class Clipboard {
  Clipboard._();
  static Future<void> copy(String text) async {
    final data = service.ClipboardData(text: text);
    await service.Clipboard.setData(data);
  }

  static Future<String> paste(String text) async {
    final data = await service.Clipboard.getData('text/plain');
    return data?.text ?? '';
  }
}
