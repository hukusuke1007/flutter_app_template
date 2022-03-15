class Ngram {
  Ngram._();

  static Set<String> parse(
    String data, {
    int n = 2,
  }) {
    final result = <String>{};
    for (var i = 0; i < data.length; i++) {
      if (n > data.length - i) {
        break;
      }
      final str = data.substring(i, i + n);
      result.add(str);
    }
    return result;
  }
}
