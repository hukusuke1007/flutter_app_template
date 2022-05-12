import 'package:hashids2/hashids2.dart';
import 'package:uuid/uuid.dart';

class UuidGenerator {
  UuidGenerator._();
  static String create({int length = 8}) {
    final hashIds = HashIds(
      salt: const Uuid().v4(),
      minHashLength: length,
    );
    final id = hashIds.encode([1, 2, 3]);
    return id;
  }

  static String get long => const Uuid().v4();
}
