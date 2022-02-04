// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'counter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Counter _$CounterFromJson(Map<String, dynamic> json) {
  return _Counter.fromJson(json);
}

/// @nodoc
class _$CounterTearOff {
  const _$CounterTearOff();

  _Counter call(
      {int? count,
      @DateTimeTimestampConverter() DateTime? createdAt,
      @DateTimeTimestampConverter() DateTime? updatedAt}) {
    return _Counter(
      count: count,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  Counter fromJson(Map<String, Object?> json) {
    return Counter.fromJson(json);
  }
}

/// @nodoc
const $Counter = _$CounterTearOff();

/// @nodoc
mixin _$Counter {
  int? get count => throw _privateConstructorUsedError;
  @DateTimeTimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @DateTimeTimestampConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CounterCopyWith<Counter> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CounterCopyWith<$Res> {
  factory $CounterCopyWith(Counter value, $Res Function(Counter) then) =
      _$CounterCopyWithImpl<$Res>;
  $Res call(
      {int? count,
      @DateTimeTimestampConverter() DateTime? createdAt,
      @DateTimeTimestampConverter() DateTime? updatedAt});
}

/// @nodoc
class _$CounterCopyWithImpl<$Res> implements $CounterCopyWith<$Res> {
  _$CounterCopyWithImpl(this._value, this._then);

  final Counter _value;
  // ignore: unused_field
  final $Res Function(Counter) _then;

  @override
  $Res call({
    Object? count = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      count: count == freezed
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
abstract class _$CounterCopyWith<$Res> implements $CounterCopyWith<$Res> {
  factory _$CounterCopyWith(_Counter value, $Res Function(_Counter) then) =
      __$CounterCopyWithImpl<$Res>;
  @override
  $Res call(
      {int? count,
      @DateTimeTimestampConverter() DateTime? createdAt,
      @DateTimeTimestampConverter() DateTime? updatedAt});
}

/// @nodoc
class __$CounterCopyWithImpl<$Res> extends _$CounterCopyWithImpl<$Res>
    implements _$CounterCopyWith<$Res> {
  __$CounterCopyWithImpl(_Counter _value, $Res Function(_Counter) _then)
      : super(_value, (v) => _then(v as _Counter));

  @override
  _Counter get _value => super._value as _Counter;

  @override
  $Res call({
    Object? count = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_Counter(
      count: count == freezed
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Counter extends _Counter {
  const _$_Counter(
      {this.count,
      @DateTimeTimestampConverter() this.createdAt,
      @DateTimeTimestampConverter() this.updatedAt})
      : super._();

  factory _$_Counter.fromJson(Map<String, dynamic> json) =>
      _$$_CounterFromJson(json);

  @override
  final int? count;
  @override
  @DateTimeTimestampConverter()
  final DateTime? createdAt;
  @override
  @DateTimeTimestampConverter()
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Counter(count: $count, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Counter &&
            const DeepCollectionEquality().equals(other.count, count) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(count),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(updatedAt));

  @JsonKey(ignore: true)
  @override
  _$CounterCopyWith<_Counter> get copyWith =>
      __$CounterCopyWithImpl<_Counter>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CounterToJson(this);
  }
}

abstract class _Counter extends Counter {
  const factory _Counter(
      {int? count,
      @DateTimeTimestampConverter() DateTime? createdAt,
      @DateTimeTimestampConverter() DateTime? updatedAt}) = _$_Counter;
  const _Counter._() : super._();

  factory _Counter.fromJson(Map<String, dynamic> json) = _$_Counter.fromJson;

  @override
  int? get count;
  @override
  @DateTimeTimestampConverter()
  DateTime? get createdAt;
  @override
  @DateTimeTimestampConverter()
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$CounterCopyWith<_Counter> get copyWith =>
      throw _privateConstructorUsedError;
}
