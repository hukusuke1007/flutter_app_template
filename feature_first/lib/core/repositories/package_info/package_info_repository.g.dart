// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'package_info_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(packageInfoRepository)
const packageInfoRepositoryProvider = PackageInfoRepositoryProvider._();

final class PackageInfoRepositoryProvider
    extends
        $FunctionalProvider<
          PackageInfoRepository,
          PackageInfoRepository,
          PackageInfoRepository
        >
    with $Provider<PackageInfoRepository> {
  const PackageInfoRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'packageInfoRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$packageInfoRepositoryHash();

  @$internal
  @override
  $ProviderElement<PackageInfoRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PackageInfoRepository create(Ref ref) {
    return packageInfoRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PackageInfoRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PackageInfoRepository>(value),
    );
  }
}

String _$packageInfoRepositoryHash() =>
    r'e3f1366adb6c0532bc03932e1f10342f5652d12d';
