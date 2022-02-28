import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final imageCompressProvider = Provider((_) => ImageCompress());

class ImageCompress {
  Future<Uint8List?> call(
    File file, {
    int quality = 90,
    int minWidth = 640,
    int minHeight = 480,
  }) =>
      FlutterImageCompress.compressWithFile(
        file.absolute.path,
        quality: quality,
        minWidth: minWidth,
        minHeight: minHeight,
      );
}
