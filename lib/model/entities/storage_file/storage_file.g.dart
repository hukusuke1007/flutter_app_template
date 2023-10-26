// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storage_file.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StorageFileImpl _$$StorageFileImplFromJson(Map<String, dynamic> json) =>
    _$StorageFileImpl(
      url: json['url'] as String,
      path: json['path'] as String,
      mimeType: json['mimeType'] as String?,
      metadata: (json['metadata'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$$StorageFileImplToJson(_$StorageFileImpl instance) =>
    <String, dynamic>{
      'url': instance.url,
      'path': instance.path,
      'mimeType': instance.mimeType,
      'metadata': instance.metadata,
    };
