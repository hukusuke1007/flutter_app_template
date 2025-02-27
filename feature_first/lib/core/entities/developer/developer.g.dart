// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'developer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DeveloperImpl _$$DeveloperImplFromJson(
  Map<String, dynamic> json,
) => $checkedCreate(r'_$DeveloperImpl', json, ($checkedConvert) {
  final val = _$DeveloperImpl(
    developerId: $checkedConvert('developerId', (v) => v as String?),
    name: $checkedConvert('name', (v) => v as String?),
    image: $checkedConvert(
      'image',
      (v) => v == null ? null : StorageFile.fromJson(v as Map<String, dynamic>),
    ),
    birthdate: $checkedConvert(
      'birthdate',
      (v) => const DateTimeTimestampConverter().fromJson(v as Timestamp?),
    ),
    createdAt: $checkedConvert(
      'createdAt',
      (v) => const DateTimeTimestampConverter().fromJson(v as Timestamp?),
    ),
    updatedAt: $checkedConvert(
      'updatedAt',
      (v) => const DateTimeTimestampConverter().fromJson(v as Timestamp?),
    ),
  );
  return val;
});

Map<String, dynamic> _$$DeveloperImplToJson(
  _$DeveloperImpl instance,
) => <String, dynamic>{
  'developerId': instance.developerId,
  'name': instance.name,
  'image': instance.image?.toJson(),
  'birthdate': const DateTimeTimestampConverter().toJson(instance.birthdate),
  'createdAt': const DateTimeTimestampConverter().toJson(instance.createdAt),
  'updatedAt': const DateTimeTimestampConverter().toJson(instance.updatedAt),
};
