// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'storage_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StorageFile {

 String get url; String get path; String? get mimeType; Map<String, String>? get metadata;
/// Create a copy of StorageFile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StorageFileCopyWith<StorageFile> get copyWith => _$StorageFileCopyWithImpl<StorageFile>(this as StorageFile, _$identity);

  /// Serializes this StorageFile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StorageFile&&(identical(other.url, url) || other.url == url)&&(identical(other.path, path) || other.path == path)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,path,mimeType,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'StorageFile(url: $url, path: $path, mimeType: $mimeType, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $StorageFileCopyWith<$Res>  {
  factory $StorageFileCopyWith(StorageFile value, $Res Function(StorageFile) _then) = _$StorageFileCopyWithImpl;
@useResult
$Res call({
 String url, String path, String? mimeType, Map<String, String>? metadata
});




}
/// @nodoc
class _$StorageFileCopyWithImpl<$Res>
    implements $StorageFileCopyWith<$Res> {
  _$StorageFileCopyWithImpl(this._self, this._then);

  final StorageFile _self;
  final $Res Function(StorageFile) _then;

/// Create a copy of StorageFile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? url = null,Object? path = null,Object? mimeType = freezed,Object? metadata = freezed,}) {
  return _then(_self.copyWith(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,mimeType: freezed == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _StorageFile extends StorageFile {
   _StorageFile({required this.url, required this.path, this.mimeType, final  Map<String, String>? metadata}): _metadata = metadata,super._();
  factory _StorageFile.fromJson(Map<String, dynamic> json) => _$StorageFileFromJson(json);

@override final  String url;
@override final  String path;
@override final  String? mimeType;
 final  Map<String, String>? _metadata;
@override Map<String, String>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of StorageFile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StorageFileCopyWith<_StorageFile> get copyWith => __$StorageFileCopyWithImpl<_StorageFile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StorageFileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StorageFile&&(identical(other.url, url) || other.url == url)&&(identical(other.path, path) || other.path == path)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,url,path,mimeType,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'StorageFile(url: $url, path: $path, mimeType: $mimeType, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$StorageFileCopyWith<$Res> implements $StorageFileCopyWith<$Res> {
  factory _$StorageFileCopyWith(_StorageFile value, $Res Function(_StorageFile) _then) = __$StorageFileCopyWithImpl;
@override @useResult
$Res call({
 String url, String path, String? mimeType, Map<String, String>? metadata
});




}
/// @nodoc
class __$StorageFileCopyWithImpl<$Res>
    implements _$StorageFileCopyWith<$Res> {
  __$StorageFileCopyWithImpl(this._self, this._then);

  final _StorageFile _self;
  final $Res Function(_StorageFile) _then;

/// Create a copy of StorageFile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? url = null,Object? path = null,Object? mimeType = freezed,Object? metadata = freezed,}) {
  return _then(_StorageFile(
url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,mimeType: freezed == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,
  ));
}


}

// dart format on
