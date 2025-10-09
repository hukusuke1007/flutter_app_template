// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_messaging_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(firebaseMessagingRepository)
const firebaseMessagingRepositoryProvider =
    FirebaseMessagingRepositoryProvider._();

final class FirebaseMessagingRepositoryProvider
    extends
        $FunctionalProvider<
          FirebaseMessagingRepository,
          FirebaseMessagingRepository,
          FirebaseMessagingRepository
        >
    with $Provider<FirebaseMessagingRepository> {
  const FirebaseMessagingRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'firebaseMessagingRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$firebaseMessagingRepositoryHash();

  @$internal
  @override
  $ProviderElement<FirebaseMessagingRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FirebaseMessagingRepository create(Ref ref) {
    return firebaseMessagingRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FirebaseMessagingRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FirebaseMessagingRepository>(value),
    );
  }
}

String _$firebaseMessagingRepositoryHash() =>
    r'babb354828b68487e527debd2ec370e36ee1c4d4';
