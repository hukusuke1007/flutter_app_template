import 'package:flutter/services.dart';

class Vibration {
  Vibration._();
  static Future<void> select() => HapticFeedback.heavyImpact();
  static Future<void> sound() => HapticFeedback.vibrate();
}
