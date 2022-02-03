extension StringExtension on String {
  DateTime toDate() => DateTime.parse(this);
  int toInt() => int.parse(this);
  double toDouble() => double.parse(this);
  bool isNewLine() => '\n' == substring(length - 1);
  bool get isUrl => RegExp(r'https?://[a-zA-Z0-9\-%_/=&?.]+').hasMatch(this);
  bool get isId => RegExp(r'[a-zA-Z0-9\-%_/=&?.]+').hasMatch(this);
}
