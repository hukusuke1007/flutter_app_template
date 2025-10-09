// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_auth_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(firebaseAuthRepository)
const firebaseAuthRepositoryProvider = FirebaseAuthRepositoryProvider._();

final class FirebaseAuthRepositoryProvider
    extends
        $FunctionalProvider<
          FirebaseAuthRepository,
          FirebaseAuthRepository,
          FirebaseAuthRepository
        >
    with $Provider<FirebaseAuthRepository> {
  const FirebaseAuthRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'firebaseAuthRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$firebaseAuthRepositoryHash();

  @$internal
  @override
  $ProviderElement<FirebaseAuthRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FirebaseAuthRepository create(Ref ref) {
    return firebaseAuthRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FirebaseAuthRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FirebaseAuthRepository>(value),
    );
  }
}

String _$firebaseAuthRepositoryHash() =>
    r'01361695684fa1525cd4aa1cdeac359ade4746fc';
