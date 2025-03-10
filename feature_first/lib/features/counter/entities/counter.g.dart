// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Counter _$CounterFromJson(Map<String, dynamic> json) =>
    $checkedCreate('_Counter', json, ($checkedConvert) {
      final val = _Counter(
        count: $checkedConvert('count', (v) => (v as num?)?.toInt()),
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

Map<String, dynamic> _$CounterToJson(_Counter instance) => <String, dynamic>{
  'count': instance.count,
  'createdAt': const DateTimeTimestampConverter().toJson(instance.createdAt),
  'updatedAt': const DateTimeTimestampConverter().toJson(instance.updatedAt),
};
