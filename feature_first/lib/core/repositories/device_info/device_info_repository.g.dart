// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_info_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(deviceInfoRepository)
const deviceInfoRepositoryProvider = DeviceInfoRepositoryProvider._();

final class DeviceInfoRepositoryProvider
    extends
        $FunctionalProvider<
          DeviceInfoRepository,
          DeviceInfoRepository,
          DeviceInfoRepository
        >
    with $Provider<DeviceInfoRepository> {
  const DeviceInfoRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceInfoRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deviceInfoRepositoryHash();

  @$internal
  @override
  $ProviderElement<DeviceInfoRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  DeviceInfoRepository create(Ref ref) {
    return deviceInfoRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeviceInfoRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeviceInfoRepository>(value),
    );
  }
}

String _$deviceInfoRepositoryHash() =>
    r'dcaf3408a6f9af373195720fa6acd3fa19a327a3';
