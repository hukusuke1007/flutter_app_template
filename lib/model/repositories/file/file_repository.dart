import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../utils/logger.dart';

final fileRepositoryProvider = Provider<FileRepository>(
  (_) => FileRepository(),
);

class FileRepository {
  bool deleteFile(String path) {
    try {
      final file = File(path);
      if (file.existsSync()) {
        File(path).deleteSync();
        logger.info('Deleted: $path');
      } else {
        logger.info('No exists: $path');
      }
      return true;
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      logger.info(e.toString());
      return false;
    }
  }
}
