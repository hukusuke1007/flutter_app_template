// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_StorageFile _$$_StorageFileFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$_StorageFile',
      json,
      ($checkedConvert) {
        final val = _$_StorageFile(
          url: $checkedConvert('url', (v) => v as String),
          path: $checkedConvert('path', (v) => v as String),
          mimeType: $checkedConvert('mime_type', (v) => v as String?),
          metadata: $checkedConvert(
              'metadata',
              (v) => (v as Map<String, dynamic>?)?.map(
                    (k, e) => MapEntry(k, e as String),
                  )),
        );
        return val;
      },
      fieldKeyMap: const {'mimeType': 'mime_type'},
    );

Map<String, dynamic> _$$_StorageFileToJson(_$_StorageFile instance) =>
    <String, dynamic>{
      'url': instance.url,
      'path': instance.path,
      'mime_type': instance.mimeType,
      'metadata': instance.metadata,
    };
