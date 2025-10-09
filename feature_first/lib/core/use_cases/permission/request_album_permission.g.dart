// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_album_permission.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(requestAlbumPermission)
const requestAlbumPermissionProvider = RequestAlbumPermissionProvider._();

final class RequestAlbumPermissionProvider
    extends
        $FunctionalProvider<
          RequestAlbumPermission,
          RequestAlbumPermission,
          RequestAlbumPermission
        >
    with $Provider<RequestAlbumPermission> {
  const RequestAlbumPermissionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'requestAlbumPermissionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$requestAlbumPermissionHash();

  @$internal
  @override
  $ProviderElement<RequestAlbumPermission> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RequestAlbumPermission create(Ref ref) {
    return requestAlbumPermission(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RequestAlbumPermission value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RequestAlbumPermission>(value),
    );
  }
}

String _$requestAlbumPermissionHash() =>
    r'0996a02a836871bd0cdce979546f3cea1eed671c';
