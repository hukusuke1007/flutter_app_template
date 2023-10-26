// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'developer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DeveloperImpl _$$DeveloperImplFromJson(Map<String, dynamic> json) =>
    _$DeveloperImpl(
      developerId: json['developerId'] as String?,
      name: json['name'] as String?,
      image: json['image'] == null
          ? null
          : StorageFile.fromJson(json['image'] as Map<String, dynamic>),
      birthdate: const DateTimeTimestampConverter()
          .fromJson(json['birthdate'] as Timestamp?),
      createdAt: const DateTimeTimestampConverter()
          .fromJson(json['createdAt'] as Timestamp?),
      updatedAt: const DateTimeTimestampConverter()
          .fromJson(json['updatedAt'] as Timestamp?),
    );

Map<String, dynamic> _$$DeveloperImplToJson(_$DeveloperImpl instance) =>
    <String, dynamic>{
      'developerId': instance.developerId,
      'name': instance.name,
      'image': instance.image?.toJson(),
      'birthdate':
          const DateTimeTimestampConverter().toJson(instance.birthdate),
      'createdAt':
          const DateTimeTimestampConverter().toJson(instance.createdAt),
      'updatedAt':
          const DateTimeTimestampConverter().toJson(instance.updatedAt),
    };
