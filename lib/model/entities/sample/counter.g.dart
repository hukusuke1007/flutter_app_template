// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Counter _$$_CounterFromJson(Map<String, dynamic> json) => $checkedCreate(
      r'_$_Counter',
      json,
      ($checkedConvert) {
        final val = _$_Counter(
          count: $checkedConvert('count', (v) => v as int?),
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
      fieldKeyMap: const {'createdAt': 'created_at', 'updatedAt': 'updated_at'},
    );

Map<String, dynamic> _$$_CounterToJson(_$_Counter instance) =>
    <String, dynamic>{
      'count': instance.count,
      'created_at':
          const DateTimeTimestampConverter().toJson(instance.createdAt),
      'updated_at':
          const DateTimeTimestampConverter().toJson(instance.updatedAt),
    };
