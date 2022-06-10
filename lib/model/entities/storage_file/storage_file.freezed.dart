// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'storage_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

StorageFile _$StorageFileFromJson(Map<String, dynamic> json) {
  return _StorageFile.fromJson(json);
}

/// @nodoc
mixin _$StorageFile {
  String get url => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;
  String? get mimeType => throw _privateConstructorUsedError;
  Map<String, String>? get metadata => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StorageFileCopyWith<StorageFile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StorageFileCopyWith<$Res> {
  factory $StorageFileCopyWith(
          StorageFile value, $Res Function(StorageFile) then) =
      _$StorageFileCopyWithImpl<$Res>;
  $Res call(
      {String url,
      String path,
      String? mimeType,
      Map<String, String>? metadata});
}

/// @nodoc
class _$StorageFileCopyWithImpl<$Res> implements $StorageFileCopyWith<$Res> {
  _$StorageFileCopyWithImpl(this._value, this._then);

  final StorageFile _value;
  // ignore: unused_field
  final $Res Function(StorageFile) _then;

  @override
  $Res call({
    Object? url = freezed,
    Object? path = freezed,
    Object? mimeType = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_value.copyWith(
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      mimeType: mimeType == freezed
          ? _value.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: metadata == freezed
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
    ));
  }
}

/// @nodoc
abstract class _$$_StorageFileCopyWith<$Res>
    implements $StorageFileCopyWith<$Res> {
  factory _$$_StorageFileCopyWith(
          _$_StorageFile value, $Res Function(_$_StorageFile) then) =
      __$$_StorageFileCopyWithImpl<$Res>;
  @override
  $Res call(
      {String url,
      String path,
      String? mimeType,
      Map<String, String>? metadata});
}

/// @nodoc
class __$$_StorageFileCopyWithImpl<$Res> extends _$StorageFileCopyWithImpl<$Res>
    implements _$$_StorageFileCopyWith<$Res> {
  __$$_StorageFileCopyWithImpl(
      _$_StorageFile _value, $Res Function(_$_StorageFile) _then)
      : super(_value, (v) => _then(v as _$_StorageFile));

  @override
  _$_StorageFile get _value => super._value as _$_StorageFile;

  @override
  $Res call({
    Object? url = freezed,
    Object? path = freezed,
    Object? mimeType = freezed,
    Object? metadata = freezed,
  }) {
    return _then(_$_StorageFile(
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      path: path == freezed
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      mimeType: mimeType == freezed
          ? _value.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String?,
      metadata: metadata == freezed
          ? _value._metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_StorageFile extends _StorageFile {
  _$_StorageFile(
      {required this.url,
      required this.path,
      this.mimeType,
      final Map<String, String>? metadata})
      : _metadata = metadata,
        super._();

  factory _$_StorageFile.fromJson(Map<String, dynamic> json) =>
      _$$_StorageFileFromJson(json);

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
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'StorageFile(url: $url, path: $path, mimeType: $mimeType, metadata: $metadata)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_StorageFile &&
            const DeepCollectionEquality().equals(other.url, url) &&
            const DeepCollectionEquality().equals(other.path, path) &&
            const DeepCollectionEquality().equals(other.mimeType, mimeType) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(url),
      const DeepCollectionEquality().hash(path),
      const DeepCollectionEquality().hash(mimeType),
      const DeepCollectionEquality().hash(_metadata));

  @JsonKey(ignore: true)
  @override
  _$$_StorageFileCopyWith<_$_StorageFile> get copyWith =>
      __$$_StorageFileCopyWithImpl<_$_StorageFile>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_StorageFileToJson(this);
  }
}

abstract class _StorageFile extends StorageFile {
  factory _StorageFile(
      {required final String url,
      required final String path,
      final String? mimeType,
      final Map<String, String>? metadata}) = _$_StorageFile;
  _StorageFile._() : super._();

  factory _StorageFile.fromJson(Map<String, dynamic> json) =
      _$_StorageFile.fromJson;

  @override
  String get url => throw _privateConstructorUsedError;
  @override
  String get path => throw _privateConstructorUsedError;
  @override
  String? get mimeType => throw _privateConstructorUsedError;
  @override
  Map<String, String>? get metadata => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_StorageFileCopyWith<_$_StorageFile> get copyWith =>
      throw _privateConstructorUsedError;
}
