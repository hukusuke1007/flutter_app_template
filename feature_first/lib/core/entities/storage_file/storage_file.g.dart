// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StorageFileImpl _$$StorageFileImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$StorageFileImpl',
      json,
      ($checkedConvert) {
        final val = _$StorageFileImpl(
          url: $checkedConvert('url', (v) => v as String),
          path: $checkedConvert('path', (v) => v as String),
          mimeType: $checkedConvert('mimeType', (v) => v as String?),
          metadata: $checkedConvert(
              'metadata',
              (v) => (v as Map<String, dynamic>?)?.map(
                    (k, e) => MapEntry(k, e as String),
                  )),
        );
        return val;
      },
    );

Map<String, dynamic> _$$StorageFileImplToJson(_$StorageFileImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'path': instance.path,
      'mimeType': instance.mimeType,
      'metadata': instance.metadata,
    };
