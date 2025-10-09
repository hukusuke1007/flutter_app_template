// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_my_user_id.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(fetchMyUserId)
const fetchMyUserIdProvider = FetchMyUserIdProvider._();

final class FetchMyUserIdProvider
    extends $FunctionalProvider<String?, String?, String?>
    with $Provider<String?> {
  const FetchMyUserIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fetchMyUserIdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fetchMyUserIdHash();

  @$internal
  @override
  $ProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String? create(Ref ref) {
    return fetchMyUserId(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$fetchMyUserIdHash() => r'daa83e5b4fcdf88645fd51c89b38da01b3562e36';
