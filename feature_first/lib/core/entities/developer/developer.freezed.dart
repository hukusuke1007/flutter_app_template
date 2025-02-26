// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'developer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Developer _$DeveloperFromJson(Map<String, dynamic> json) {
  return _Developer.fromJson(json);
}

/// @nodoc
mixin _$Developer {
  String? get developerId => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  StorageFile? get image => throw _privateConstructorUsedError;
  @DateTimeTimestampConverter()
  DateTime? get birthdate => throw _privateConstructorUsedError;
  @DateTimeTimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @DateTimeTimestampConverter()
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Developer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Developer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeveloperCopyWith<Developer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeveloperCopyWith<$Res> {
  factory $DeveloperCopyWith(Developer value, $Res Function(Developer) then) =
      _$DeveloperCopyWithImpl<$Res, Developer>;
  @useResult
  $Res call(
      {String? developerId,
      String? name,
      StorageFile? image,
      @DateTimeTimestampConverter() DateTime? birthdate,
      @DateTimeTimestampConverter() DateTime? createdAt,
      @DateTimeTimestampConverter() DateTime? updatedAt});

  $StorageFileCopyWith<$Res>? get image;
}

/// @nodoc
class _$DeveloperCopyWithImpl<$Res, $Val extends Developer>
    implements $DeveloperCopyWith<$Res> {
  _$DeveloperCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Developer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? developerId = freezed,
    Object? name = freezed,
    Object? image = freezed,
    Object? birthdate = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      developerId: freezed == developerId
          ? _value.developerId
          : developerId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as StorageFile?,
      birthdate: freezed == birthdate
          ? _value.birthdate
          : birthdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  /// Create a copy of Developer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StorageFileCopyWith<$Res>? get image {
    if (_value.image == null) {
      return null;
    }

    return $StorageFileCopyWith<$Res>(_value.image!, (value) {
      return _then(_value.copyWith(image: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DeveloperImplCopyWith<$Res>
    implements $DeveloperCopyWith<$Res> {
  factory _$$DeveloperImplCopyWith(
          _$DeveloperImpl value, $Res Function(_$DeveloperImpl) then) =
      __$$DeveloperImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? developerId,
      String? name,
      StorageFile? image,
      @DateTimeTimestampConverter() DateTime? birthdate,
      @DateTimeTimestampConverter() DateTime? createdAt,
      @DateTimeTimestampConverter() DateTime? updatedAt});

  @override
  $StorageFileCopyWith<$Res>? get image;
}

/// @nodoc
class __$$DeveloperImplCopyWithImpl<$Res>
    extends _$DeveloperCopyWithImpl<$Res, _$DeveloperImpl>
    implements _$$DeveloperImplCopyWith<$Res> {
  __$$DeveloperImplCopyWithImpl(
      _$DeveloperImpl _value, $Res Function(_$DeveloperImpl) _then)
      : super(_value, _then);

  /// Create a copy of Developer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? developerId = freezed,
    Object? name = freezed,
    Object? image = freezed,
    Object? birthdate = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$DeveloperImpl(
      developerId: freezed == developerId
          ? _value.developerId
          : developerId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as StorageFile?,
      birthdate: freezed == birthdate
          ? _value.birthdate
          : birthdate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DeveloperImpl extends _Developer {
  const _$DeveloperImpl(
      {this.developerId,
      this.name,
      this.image,
      @DateTimeTimestampConverter() this.birthdate,
      @DateTimeTimestampConverter() this.createdAt,
      @DateTimeTimestampConverter() this.updatedAt})
      : super._();

  factory _$DeveloperImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeveloperImplFromJson(json);

  @override
  final String? developerId;
  @override
  final String? name;
  @override
  final StorageFile? image;
  @override
  @DateTimeTimestampConverter()
  final DateTime? birthdate;
  @override
  @DateTimeTimestampConverter()
  final DateTime? createdAt;
  @override
  @DateTimeTimestampConverter()
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Developer(developerId: $developerId, name: $name, image: $image, birthdate: $birthdate, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeveloperImpl &&
            (identical(other.developerId, developerId) ||
                other.developerId == developerId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.birthdate, birthdate) ||
                other.birthdate == birthdate) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, developerId, name, image, birthdate, createdAt, updatedAt);

  /// Create a copy of Developer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeveloperImplCopyWith<_$DeveloperImpl> get copyWith =>
      __$$DeveloperImplCopyWithImpl<_$DeveloperImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeveloperImplToJson(
      this,
    );
  }
}

abstract class _Developer extends Developer {
  const factory _Developer(
          {final String? developerId,
          final String? name,
          final StorageFile? image,
          @DateTimeTimestampConverter() final DateTime? birthdate,
          @DateTimeTimestampConverter() final DateTime? createdAt,
          @DateTimeTimestampConverter() final DateTime? updatedAt}) =
      _$DeveloperImpl;
  const _Developer._() : super._();

  factory _Developer.fromJson(Map<String, dynamic> json) =
      _$DeveloperImpl.fromJson;

  @override
  String? get developerId;
  @override
  String? get name;
  @override
  StorageFile? get image;
  @override
  @DateTimeTimestampConverter()
  DateTime? get birthdate;
  @override
  @DateTimeTimestampConverter()
  DateTime? get createdAt;
  @override
  @DateTimeTimestampConverter()
  DateTime? get updatedAt;

  /// Create a copy of Developer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeveloperImplCopyWith<_$DeveloperImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
