import 'package:encrypt/encrypt.dart';

class EncryptHelper {
  EncryptHelper._();
  static Encrypted encryptAES(String plainText, {required String rawKey}) {
    final key = Key.fromUtf8(rawKey);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return encrypted;
  }

  static String decrypt16AES(String encoded, {required String rawKey}) {
    final key = Key.fromUtf8(rawKey);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    final decrypted = encrypter.decrypt16(encoded, iv: iv);
    return decrypted;
  }

  static String decrypt64AES(String encoded, {required String rawKey}) {
    final key = Key.fromUtf8(rawKey);
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    final decrypted = encrypter.decrypt64(encoded, iv: iv);
    return decrypted;
  }
}
