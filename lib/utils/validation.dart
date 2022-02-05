class Validation {
  Validation._();
  static bool isUserId(String text) {
    return RegExp(r'^([a-zA-Z0-9]{4,})$').hasMatch(text);
  }
}
