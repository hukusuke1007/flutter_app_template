// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_logged_in_with_anonymously.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(fetchLoggedInWithAnonymously)
const fetchLoggedInWithAnonymouslyProvider =
    FetchLoggedInWithAnonymouslyProvider._();

final class FetchLoggedInWithAnonymouslyProvider
    extends
        $FunctionalProvider<
          FetchLoggedInWithAnonymously,
          FetchLoggedInWithAnonymously,
          FetchLoggedInWithAnonymously
        >
    with $Provider<FetchLoggedInWithAnonymously> {
  const FetchLoggedInWithAnonymouslyProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fetchLoggedInWithAnonymouslyProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fetchLoggedInWithAnonymouslyHash();

  @$internal
  @override
  $ProviderElement<FetchLoggedInWithAnonymously> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FetchLoggedInWithAnonymously create(Ref ref) {
    return fetchLoggedInWithAnonymously(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FetchLoggedInWithAnonymously value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FetchLoggedInWithAnonymously>(value),
    );
  }
}

String _$fetchLoggedInWithAnonymouslyHash() =>
    r'5ff80d03e1f0485a2b23c91943decea239a1c585';
