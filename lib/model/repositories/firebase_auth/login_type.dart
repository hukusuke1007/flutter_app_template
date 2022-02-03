enum LoginType {
  apple,
  google,
  anonymously,
}

extension LoginTypeExtension on LoginType {
  String get value => toString().replaceAll('$runtimeType.', '');
}
