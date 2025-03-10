// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Post _$PostFromJson(Map<String, dynamic> json) => $checkedCreate(
  '_Post',
  json,
  ($checkedConvert) {
    final val = _Post(
      postId: $checkedConvert('postId', (v) => v as String),
      userId: $checkedConvert('userId', (v) => v as String),
      text: $checkedConvert('text', (v) => v as String),
      likeCount: $checkedConvert('likeCount', (v) => (v as num?)?.toInt() ?? 0),
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
  },
);

Map<String, dynamic> _$PostToJson(_Post instance) => <String, dynamic>{
  'postId': instance.postId,
  'userId': instance.userId,
  'text': instance.text,
  'likeCount': instance.likeCount,
  'createdAt': const DateTimeTimestampConverter().toJson(instance.createdAt),
  'updatedAt': const DateTimeTimestampConverter().toJson(instance.updatedAt),
};
