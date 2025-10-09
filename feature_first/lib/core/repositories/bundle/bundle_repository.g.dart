// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bundle_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(bundleRepository)
const bundleRepositoryProvider = BundleRepositoryProvider._();

final class BundleRepositoryProvider
    extends
        $FunctionalProvider<
          BundleRepository,
          BundleRepository,
          BundleRepository
        >
    with $Provider<BundleRepository> {
  const BundleRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bundleRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bundleRepositoryHash();

  @$internal
  @override
  $ProviderElement<BundleRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BundleRepository create(Ref ref) {
    return bundleRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BundleRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BundleRepository>(value),
    );
  }
}

String _$bundleRepositoryHash() => r'd844c5b9abec7e1a1b13042599cca668da4df9df';
