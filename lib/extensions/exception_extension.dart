import 'package:flutter/services.dart';

extension ExceptionExtension on Exception {
  String get errorMessage {
    final e = this;
    if (e is PlatformException && e.message != null) {
      return e.message!;
    }
    return toString().replaceAll('Exception: ', '');
  }
}
