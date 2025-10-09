import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'image_compress.g.dart';

@Riverpod(keepAlive: true)
ImageCompress imageCompress(Ref ref) {
  throw UnimplementedError();
}

class ImageCompress {
  ImageCompress(this._tempDirectory);

  final Directory _tempDirectory;

  Future<Uint8List?> call(
    File file, {
    int quality = 95,
    int minWidth = 1024,
    int minHeight = 1024,
  }) => FlutterImageCompress.compressWithFile(
    file.absolute.path,
    quality: quality,
    minWidth: minWidth,
    minHeight: minHeight,
  );

  Future<XFile?> callWithPath(
    String path, {
    int quality = 95,
    int minWidth = 1024,
    int minHeight = 1024,
  }) {
    // .jpgを末尾に付与にしないとエラーを吐くため
    final directory = Directory(
      '${_tempDirectory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg',
    );
    final tempFile = File(directory.path);
    return FlutterImageCompress.compressAndGetFile(
      path,
      tempFile.absolute.path,
      quality: quality,
      minWidth: minWidth,
      minHeight: minHeight,
      // ignore: avoid_redundant_argument_values
      format: CompressFormat.jpeg,
    );
  }
}
