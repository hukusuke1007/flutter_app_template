class AppException implements Exception {
  AppException({
    this.title,
    this.detail,
  });

  factory AppException.error(String title) => AppException(title: title);
  factory AppException.unknown() => AppException(title: '不明なエラーです');
  factory AppException.irregular() => AppException(title: 'イレギュラーエラーです');

  final String? title;
  final String? detail;

  @override
  String toString() => '${title ?? ''}${detail != null ? ', $detail' : ''}';
}
