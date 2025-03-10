// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'memo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Memo {

 String? get memoId; String? get text;@DateTimeTimestampConverter() DateTime? get createdAt;@DateTimeTimestampConverter() DateTime? get updatedAt;
/// Create a copy of Memo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MemoCopyWith<Memo> get copyWith => _$MemoCopyWithImpl<Memo>(this as Memo, _$identity);

  /// Serializes this Memo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Memo&&(identical(other.memoId, memoId) || other.memoId == memoId)&&(identical(other.text, text) || other.text == text)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,memoId,text,createdAt,updatedAt);

@override
String toString() {
  return 'Memo(memoId: $memoId, text: $text, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $MemoCopyWith<$Res>  {
  factory $MemoCopyWith(Memo value, $Res Function(Memo) _then) = _$MemoCopyWithImpl;
@useResult
$Res call({
 String? memoId, String? text,@DateTimeTimestampConverter() DateTime? createdAt,@DateTimeTimestampConverter() DateTime? updatedAt
});




}
/// @nodoc
class _$MemoCopyWithImpl<$Res>
    implements $MemoCopyWith<$Res> {
  _$MemoCopyWithImpl(this._self, this._then);

  final Memo _self;
  final $Res Function(Memo) _then;

/// Create a copy of Memo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? memoId = freezed,Object? text = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
memoId: freezed == memoId ? _self.memoId : memoId // ignore: cast_nullable_to_non_nullable
as String?,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Memo extends Memo {
  const _Memo({this.memoId, this.text, @DateTimeTimestampConverter() this.createdAt, @DateTimeTimestampConverter() this.updatedAt}): super._();
  factory _Memo.fromJson(Map<String, dynamic> json) => _$MemoFromJson(json);

@override final  String? memoId;
@override final  String? text;
@override@DateTimeTimestampConverter() final  DateTime? createdAt;
@override@DateTimeTimestampConverter() final  DateTime? updatedAt;

/// Create a copy of Memo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MemoCopyWith<_Memo> get copyWith => __$MemoCopyWithImpl<_Memo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MemoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Memo&&(identical(other.memoId, memoId) || other.memoId == memoId)&&(identical(other.text, text) || other.text == text)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,memoId,text,createdAt,updatedAt);

@override
String toString() {
  return 'Memo(memoId: $memoId, text: $text, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$MemoCopyWith<$Res> implements $MemoCopyWith<$Res> {
  factory _$MemoCopyWith(_Memo value, $Res Function(_Memo) _then) = __$MemoCopyWithImpl;
@override @useResult
$Res call({
 String? memoId, String? text,@DateTimeTimestampConverter() DateTime? createdAt,@DateTimeTimestampConverter() DateTime? updatedAt
});




}
/// @nodoc
class __$MemoCopyWithImpl<$Res>
    implements _$MemoCopyWith<$Res> {
  __$MemoCopyWithImpl(this._self, this._then);

  final _Memo _self;
  final $Res Function(_Memo) _then;

/// Create a copy of Memo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? memoId = freezed,Object? text = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_Memo(
memoId: freezed == memoId ? _self.memoId : memoId // ignore: cast_nullable_to_non_nullable
as String?,text: freezed == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
