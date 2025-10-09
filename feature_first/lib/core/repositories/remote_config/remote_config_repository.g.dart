// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_config_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(remoteConfigRepository)
const remoteConfigRepositoryProvider = RemoteConfigRepositoryProvider._();

final class RemoteConfigRepositoryProvider
    extends
        $FunctionalProvider<
          RemoteConfigRepository,
          RemoteConfigRepository,
          RemoteConfigRepository
        >
    with $Provider<RemoteConfigRepository> {
  const RemoteConfigRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'remoteConfigRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$remoteConfigRepositoryHash();

  @$internal
  @override
  $ProviderElement<RemoteConfigRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RemoteConfigRepository create(Ref ref) {
    return remoteConfigRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RemoteConfigRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RemoteConfigRepository>(value),
    );
  }
}

String _$remoteConfigRepositoryHash() =>
    r'755f1f09acbe68b216909edd60ba3dd648c2dc8d';
