// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_app_name.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(fetchAppName)
const fetchAppNameProvider = FetchAppNameProvider._();

final class FetchAppNameProvider
    extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  const FetchAppNameProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fetchAppNameProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fetchAppNameHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return fetchAppName(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$fetchAppNameHash() => r'f6bed771aae3e952d2a1ac6d7803179799f43b40';
