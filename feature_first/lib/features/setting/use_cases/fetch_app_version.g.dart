// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_app_version.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(fetchAppVersion)
const fetchAppVersionProvider = FetchAppVersionProvider._();

final class FetchAppVersionProvider
    extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  const FetchAppVersionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fetchAppVersionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fetchAppVersionHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return fetchAppVersion(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$fetchAppVersionHash() => r'58a6b941f0b03d191a2fa34b764c05e1850941cd';
