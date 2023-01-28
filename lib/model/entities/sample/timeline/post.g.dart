// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Post _$$_PostFromJson(Map<String, dynamic> json) => _$_Post(
      postId: json['postId'] as String,
      userId: json['userId'] as String,
      text: json['text'] as String,
      likeCount: json['likeCount'] as int? ?? 0,
      createdAt: const DateTimeTimestampConverter()
          .fromJson(json['createdAt'] as Timestamp?),
      updatedAt: const DateTimeTimestampConverter()
          .fromJson(json['updatedAt'] as Timestamp?),
    );

Map<String, dynamic> _$$_PostToJson(_$_Post instance) => <String, dynamic>{
      'postId': instance.postId,
      'userId': instance.userId,
      'text': instance.text,
      'likeCount': instance.likeCount,
      'createdAt':
          const DateTimeTimestampConverter().toJson(instance.createdAt),
      'updatedAt':
          const DateTimeTimestampConverter().toJson(instance.updatedAt),
    };
