// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Memo _$$_MemoFromJson(Map<String, dynamic> json) => $checkedCreate(
      r'_$_Memo',
      json,
      ($checkedConvert) {
        final val = _$_Memo(
          memoId: $checkedConvert('memo_id', (v) => v as String?),
          text: $checkedConvert('text', (v) => v as String?),
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
        'memoId': 'memo_id',
        'createdAt': 'created_at',
        'updatedAt': 'updated_at'
      },
    );

Map<String, dynamic> _$$_MemoToJson(_$_Memo instance) => <String, dynamic>{
      'memo_id': instance.memoId,
      'text': instance.text,
      'created_at':
          const DateTimeTimestampConverter().toJson(instance.createdAt),
      'updated_at':
          const DateTimeTimestampConverter().toJson(instance.updatedAt),
    };
