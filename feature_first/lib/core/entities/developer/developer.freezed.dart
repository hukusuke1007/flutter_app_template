// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'developer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Developer {

 String? get developerId; String? get name; StorageFile? get image;@DateTimeTimestampConverter() DateTime? get birthdate;@DateTimeTimestampConverter() DateTime? get createdAt;@DateTimeTimestampConverter() DateTime? get updatedAt;
/// Create a copy of Developer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeveloperCopyWith<Developer> get copyWith => _$DeveloperCopyWithImpl<Developer>(this as Developer, _$identity);

  /// Serializes this Developer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Developer&&(identical(other.developerId, developerId) || other.developerId == developerId)&&(identical(other.name, name) || other.name == name)&&(identical(other.image, image) || other.image == image)&&(identical(other.birthdate, birthdate) || other.birthdate == birthdate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,developerId,name,image,birthdate,createdAt,updatedAt);

@override
String toString() {
  return 'Developer(developerId: $developerId, name: $name, image: $image, birthdate: $birthdate, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $DeveloperCopyWith<$Res>  {
  factory $DeveloperCopyWith(Developer value, $Res Function(Developer) _then) = _$DeveloperCopyWithImpl;
@useResult
$Res call({
 String? developerId, String? name, StorageFile? image,@DateTimeTimestampConverter() DateTime? birthdate,@DateTimeTimestampConverter() DateTime? createdAt,@DateTimeTimestampConverter() DateTime? updatedAt
});


$StorageFileCopyWith<$Res>? get image;

}
/// @nodoc
class _$DeveloperCopyWithImpl<$Res>
    implements $DeveloperCopyWith<$Res> {
  _$DeveloperCopyWithImpl(this._self, this._then);

  final Developer _self;
  final $Res Function(Developer) _then;

/// Create a copy of Developer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? developerId = freezed,Object? name = freezed,Object? image = freezed,Object? birthdate = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
developerId: freezed == developerId ? _self.developerId : developerId // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as StorageFile?,birthdate: freezed == birthdate ? _self.birthdate : birthdate // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of Developer
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StorageFileCopyWith<$Res>? get image {
    if (_self.image == null) {
    return null;
  }

  return $StorageFileCopyWith<$Res>(_self.image!, (value) {
    return _then(_self.copyWith(image: value));
  });
}
}


/// Adds pattern-matching-related methods to [Developer].
extension DeveloperPatterns on Developer {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Developer value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Developer() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Developer value)  $default,){
final _that = this;
switch (_that) {
case _Developer():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Developer value)?  $default,){
final _that = this;
switch (_that) {
case _Developer() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? developerId,  String? name,  StorageFile? image, @DateTimeTimestampConverter()  DateTime? birthdate, @DateTimeTimestampConverter()  DateTime? createdAt, @DateTimeTimestampConverter()  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Developer() when $default != null:
return $default(_that.developerId,_that.name,_that.image,_that.birthdate,_that.createdAt,_that.updatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? developerId,  String? name,  StorageFile? image, @DateTimeTimestampConverter()  DateTime? birthdate, @DateTimeTimestampConverter()  DateTime? createdAt, @DateTimeTimestampConverter()  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Developer():
return $default(_that.developerId,_that.name,_that.image,_that.birthdate,_that.createdAt,_that.updatedAt);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? developerId,  String? name,  StorageFile? image, @DateTimeTimestampConverter()  DateTime? birthdate, @DateTimeTimestampConverter()  DateTime? createdAt, @DateTimeTimestampConverter()  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Developer() when $default != null:
return $default(_that.developerId,_that.name,_that.image,_that.birthdate,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Developer extends Developer {
  const _Developer({this.developerId, this.name, this.image, @DateTimeTimestampConverter() this.birthdate, @DateTimeTimestampConverter() this.createdAt, @DateTimeTimestampConverter() this.updatedAt}): super._();
  factory _Developer.fromJson(Map<String, dynamic> json) => _$DeveloperFromJson(json);

@override final  String? developerId;
@override final  String? name;
@override final  StorageFile? image;
@override@DateTimeTimestampConverter() final  DateTime? birthdate;
@override@DateTimeTimestampConverter() final  DateTime? createdAt;
@override@DateTimeTimestampConverter() final  DateTime? updatedAt;

/// Create a copy of Developer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeveloperCopyWith<_Developer> get copyWith => __$DeveloperCopyWithImpl<_Developer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeveloperToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Developer&&(identical(other.developerId, developerId) || other.developerId == developerId)&&(identical(other.name, name) || other.name == name)&&(identical(other.image, image) || other.image == image)&&(identical(other.birthdate, birthdate) || other.birthdate == birthdate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,developerId,name,image,birthdate,createdAt,updatedAt);

@override
String toString() {
  return 'Developer(developerId: $developerId, name: $name, image: $image, birthdate: $birthdate, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$DeveloperCopyWith<$Res> implements $DeveloperCopyWith<$Res> {
  factory _$DeveloperCopyWith(_Developer value, $Res Function(_Developer) _then) = __$DeveloperCopyWithImpl;
@override @useResult
$Res call({
 String? developerId, String? name, StorageFile? image,@DateTimeTimestampConverter() DateTime? birthdate,@DateTimeTimestampConverter() DateTime? createdAt,@DateTimeTimestampConverter() DateTime? updatedAt
});


@override $StorageFileCopyWith<$Res>? get image;

}
/// @nodoc
class __$DeveloperCopyWithImpl<$Res>
    implements _$DeveloperCopyWith<$Res> {
  __$DeveloperCopyWithImpl(this._self, this._then);

  final _Developer _self;
  final $Res Function(_Developer) _then;

/// Create a copy of Developer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? developerId = freezed,Object? name = freezed,Object? image = freezed,Object? birthdate = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_Developer(
developerId: freezed == developerId ? _self.developerId : developerId // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as StorageFile?,birthdate: freezed == birthdate ? _self.birthdate : birthdate // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of Developer
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StorageFileCopyWith<$Res>? get image {
    if (_self.image == null) {
    return null;
  }

  return $StorageFileCopyWith<$Res>(_self.image!, (value) {
    return _then(_self.copyWith(image: value));
  });
}
}

// dart format on
