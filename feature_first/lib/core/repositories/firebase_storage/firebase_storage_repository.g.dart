// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_storage_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(firebaseStorageRepository)
const firebaseStorageRepositoryProvider = FirebaseStorageRepositoryProvider._();

final class FirebaseStorageRepositoryProvider
    extends
        $FunctionalProvider<
          FirebaseStorageRepository,
          FirebaseStorageRepository,
          FirebaseStorageRepository
        >
    with $Provider<FirebaseStorageRepository> {
  const FirebaseStorageRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'firebaseStorageRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$firebaseStorageRepositoryHash();

  @$internal
  @override
  $ProviderElement<FirebaseStorageRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FirebaseStorageRepository create(Ref ref) {
    return firebaseStorageRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FirebaseStorageRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FirebaseStorageRepository>(value),
    );
  }
}

String _$firebaseStorageRepositoryHash() =>
    r'dd24d6edcba9d3e8a572fb08360b131dae472acf';
