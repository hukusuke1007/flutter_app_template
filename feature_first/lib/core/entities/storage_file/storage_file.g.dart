// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StorageFile _$StorageFileFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_StorageFile', json, ($checkedConvert) {
      final val = _StorageFile(
        url: $checkedConvert('url', (v) => v as String),
        path: $checkedConvert('path', (v) => v as String),
        mimeType: $checkedConvert('mimeType', (v) => v as String?),
        metadata: $checkedConvert(
          'metadata',
          (v) => (v as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ),
        ),
      );
      return val;
    });

Map<String, dynamic> _$StorageFileToJson(_StorageFile instance) =>
    <String, dynamic>{
      'url': instance.url,
      'path': instance.path,
      'mimeType': instance.mimeType,
      'metadata': instance.metadata,
    };
