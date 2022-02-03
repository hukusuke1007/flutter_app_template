class AppException implements Exception {
  AppException({
    this.title,
    this.detail,
  });

  final String? title;
  final String? detail;

  @override
  String toString() => '$title, $detail';
}
