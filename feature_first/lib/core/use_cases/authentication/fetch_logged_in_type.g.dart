// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_logged_in_type.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(fetchLoggedInType)
const fetchLoggedInTypeProvider = FetchLoggedInTypeProvider._();

final class FetchLoggedInTypeProvider
    extends
        $FunctionalProvider<
          FetchLoggedInType,
          FetchLoggedInType,
          FetchLoggedInType
        >
    with $Provider<FetchLoggedInType> {
  const FetchLoggedInTypeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fetchLoggedInTypeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fetchLoggedInTypeHash();

  @$internal
  @override
  $ProviderElement<FetchLoggedInType> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FetchLoggedInType create(Ref ref) {
    return fetchLoggedInType(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FetchLoggedInType value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FetchLoggedInType>(value),
    );
  }
}

String _$fetchLoggedInTypeHash() => r'1cf9247b20f90d6957c275406f5579380a58d980';
