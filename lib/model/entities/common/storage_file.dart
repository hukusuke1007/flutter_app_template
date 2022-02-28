import 'package:freezed_annotation/freezed_annotation.dart';

part 'storage_file.freezed.dart';
part 'storage_file.g.dart';

@freezed
class StorageFile with _$StorageFile {
  factory StorageFile({
    required String url,
    required String path,
    String? mimeType,
    Map<String, String>? metadata,
  }) = _StorageFile;
  StorageFile._();

  factory StorageFile.fromJson(Map<String, dynamic> json) =>
      _$StorageFileFromJson(json);
}
