// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Counter _$$_CounterFromJson(Map<String, dynamic> json) => _$_Counter(
      counterId: json['counterId'] as String?,
      count: json['count'] as int?,
      createdAt: const DateTimeTimestampConverter()
          .fromJson(json['createdAt'] as Timestamp?),
      updatedAt: const DateTimeTimestampConverter()
          .fromJson(json['updatedAt'] as Timestamp?),
    );

Map<String, dynamic> _$$_CounterToJson(_$_Counter instance) =>
    <String, dynamic>{
      'counterId': instance.counterId,
      'count': instance.count,
      'createdAt':
          const DateTimeTimestampConverter().toJson(instance.createdAt),
      'updatedAt':
          const DateTimeTimestampConverter().toJson(instance.updatedAt),
    };
