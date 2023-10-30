import 'package:intl/intl.dart';

extension NumExtension on num {
  String get formatComma => NumberFormat().format(this);
}
