import 'package:flutter/services.dart';

import '../exceptions/app_exception.dart';

extension ExceptionExtension on Exception {
  String get errorMessage {
    final e = this;
    if (e is PlatformException && e.message != null) {
      return e.message!;
    }
    if (e is AppException) {
      return e.title ?? e.detail ?? '';
    }
    return toString().replaceAll('Exception: ', '');
  }
}
