// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'developer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Developer _$$_DeveloperFromJson(Map<String, dynamic> json) => $checkedCreate(
      r'_$_Developer',
      json,
      ($checkedConvert) {
        final val = _$_Developer(
          developerId: $checkedConvert('developer_id', (v) => v as String?),
          name: $checkedConvert('name', (v) => v as String?),
          image: $checkedConvert(
              'image',
              (v) => v == null
                  ? null
                  : StorageFile.fromJson(v as Map<String, dynamic>)),
          birthdate: $checkedConvert(
              'birthdate',
              (v) =>
                  const DateTimeTimestampConverter().fromJson(v as Timestamp?)),
          createdAt: $checkedConvert(
              'created_at',
              (v) =>
                  const DateTimeTimestampConverter().fromJson(v as Timestamp?)),
          updatedAt: $checkedConvert(
              'updated_at',
              (v) =>
                  const DateTimeTimestampConverter().fromJson(v as Timestamp?)),
        );
        return val;
      },
      fieldKeyMap: const {
        'developerId': 'developer_id',
        'createdAt': 'created_at',
        'updatedAt': 'updated_at'
      },
    );

Map<String, dynamic> _$$_DeveloperToJson(_$_Developer instance) =>
    <String, dynamic>{
      'developer_id': instance.developerId,
      'name': instance.name,
      'image': instance.image?.toJson(),
      'birthdate':
          const DateTimeTimestampConverter().toJson(instance.birthdate),
      'created_at':
          const DateTimeTimestampConverter().toJson(instance.createdAt),
      'updated_at':
          const DateTimeTimestampConverter().toJson(instance.updatedAt),
    };
