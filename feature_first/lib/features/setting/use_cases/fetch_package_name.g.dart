// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_package_name.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(fetchPackageName)
const fetchPackageNameProvider = FetchPackageNameProvider._();

final class FetchPackageNameProvider
    extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  const FetchPackageNameProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fetchPackageNameProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fetchPackageNameHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return fetchPackageName(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$fetchPackageNameHash() => r'e772dd30cbbed54387e4a91801569a0e7052451c';
