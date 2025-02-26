// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'storage_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

StorageFile _$StorageFileFromJson(Map<String, dynamic> json) {
  return _StorageFile.fromJson(json);
}

/// @nodoc
mixin _$StorageFile {
  String get url => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;
  String? get mimeType => throw _privateConstructorUsedError;
  Map<String, String>? get metadata => throw _privateConstructorUsedError;

  /// Serializes this StorageFile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StorageFile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StorageFileCopyWith<StorageFile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StorageFileCopyWith<$Res> {
  factory $StorageFileCopyWith(
          StorageFile value, $Res Function(StorageFile) then) =
      _$StorageFileCopyWithImpl<$Res, StorageFile>;
  @useResult
  $Res call(
      {String url,
      String path,
      String? mimeType,
      Map<String, String>? metadata});
}

/// @nodoc
class _$StorageFileCopyWithImpl<$Res, $Val extends StorageFile>
    implements $StorageFileCopyWith<$Res> {
  _$StorageFileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StorageFile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? path = null,
    Object? mimeType = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      mimeType: freezed == mimeType
          ? _value.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StorageFileImplCopyWith<$Res>
    implements $StorageFileCopyWith<$Res> {
  factory _$$StorageFileImplCopyWith(
          _$StorageFileImpl value, $Res Function(_$StorageFileImpl) then) =
      __$$StorageFileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String url,
      String path,
      String? mimeType,
      Map<String, String>? metadata});
}

/// @nodoc
class __$$StorageFileImplCopyWithImpl<$Res>
    extends _$StorageFileCopyWithImpl<$Res, _$StorageFileImpl>
    implements _$$StorageFileImplCopyWith<$Res> {
  __$$StorageFileImplCopyWithImpl(
      _$StorageFileImpl _value, $Res Function(_$StorageFileImpl) _then)
      : super(_value, _then);

  /// Create a copy of StorageFile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? path = null,
    Object? mimeType = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$StorageFileImpl(
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      mimeType: freezed == mimeType
          ? _value.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: freezed == metadata
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StorageFileImpl extends _StorageFile {
  _$StorageFileImpl(
      {required this.url,
      required this.path,
      this.mimeType,
      final Map<String, String>? metadata})
      : _metadata = metadata,
        super._();

  factory _$StorageFileImpl.fromJson(Map<String, dynamic> json) =>
      _$$StorageFileImplFromJson(json);

  @override
  final String url;
  @override
  final String path;
  @override
  final String? mimeType;
  final Map<String, String>? _metadata;
  @override
  Map<String, String>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'StorageFile(url: $url, path: $path, mimeType: $mimeType, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StorageFileImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.path, path) || other.path == path) &&
            (identical(other.mimeType, mimeType) ||
                other.mimeType == mimeType) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, url, path, mimeType,
      const DeepCollectionEquality().hash(_metadata));

  /// Create a copy of StorageFile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StorageFileImplCopyWith<_$StorageFileImpl> get copyWith =>
      __$$StorageFileImplCopyWithImpl<_$StorageFileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StorageFileImplToJson(
      this,
    );
  }
}

abstract class _StorageFile extends StorageFile {
  factory _StorageFile(
      {required final String url,
      required final String path,
      final String? mimeType,
      final Map<String, String>? metadata}) = _$StorageFileImpl;
  _StorageFile._() : super._();

  factory _StorageFile.fromJson(Map<String, dynamic> json) =
      _$StorageFileImpl.fromJson;

  @override
  String get url;
  @override
  String get path;
  @override
  String? get mimeType;
  @override
  Map<String, String>? get metadata;

  /// Create a copy of StorageFile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StorageFileImplCopyWith<_$StorageFileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
