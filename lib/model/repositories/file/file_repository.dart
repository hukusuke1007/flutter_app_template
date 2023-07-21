import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final fileRepositoryProvider = Provider<FileRepository>(
  (_) => FileRepository(),
);

class FileRepository {
  Future<bool> delete(String path) async {
    final result = await compute(deleteSync, path);
    return result;
  }

  bool deleteSync(String path) {
    try {
      final file = File(path);
      if (file.existsSync()) {
        file.deleteSync();
        debugPrint('Deleted: $path');
      } else {
        debugPrint('No exists: $path');
      }
      return true;
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
