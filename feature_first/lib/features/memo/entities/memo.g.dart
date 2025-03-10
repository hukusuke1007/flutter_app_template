// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Memo _$MemoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Memo', json, ($checkedConvert) {
      final val = _Memo(
        memoId: $checkedConvert('memoId', (v) => v as String?),
        text: $checkedConvert('text', (v) => v as String?),
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

Map<String, dynamic> _$MemoToJson(_Memo instance) => <String, dynamic>{
  'memoId': instance.memoId,
  'text': instance.text,
  'createdAt': const DateTimeTimestampConverter().toJson(instance.createdAt),
  'updatedAt': const DateTimeTimestampConverter().toJson(instance.updatedAt),
};
