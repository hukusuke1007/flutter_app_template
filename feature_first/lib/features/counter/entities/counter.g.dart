// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CounterImpl _$$CounterImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$CounterImpl',
      json,
      ($checkedConvert) {
        final val = _$CounterImpl(
          count: $checkedConvert('count', (v) => v as int?),
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

Map<String, dynamic> _$$CounterImplToJson(_$CounterImpl instance) =>
    <String, dynamic>{
      'count': instance.count,
      'createdAt':
          const DateTimeTimestampConverter().toJson(instance.createdAt),
      'updatedAt':
          const DateTimeTimestampConverter().toJson(instance.updatedAt),
    };
