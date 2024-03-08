// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MemoImpl _$$MemoImplFromJson(Map<String, dynamic> json) => $checkedCreate(
      r'_$MemoImpl',
      json,
      ($checkedConvert) {
        final val = _$MemoImpl(
          memoId: $checkedConvert('memoId', (v) => v as String?),
          text: $checkedConvert('text', (v) => v as String?),
          createdAt: $checkedConvert(
              'createdAt',
              (v) =>
                  const DateTimeTimestampConverter().fromJson(v as Timestamp?)),
          updatedAt: $checkedConvert(
              'updatedAt',
              (v) =>
                  const DateTimeTimestampConverter().fromJson(v as Timestamp?)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$MemoImplToJson(_$MemoImpl instance) =>
    <String, dynamic>{
      'memoId': instance.memoId,
      'text': instance.text,
      'createdAt':
          const DateTimeTimestampConverter().toJson(instance.createdAt),
      'updatedAt':
          const DateTimeTimestampConverter().toJson(instance.updatedAt),
    };
