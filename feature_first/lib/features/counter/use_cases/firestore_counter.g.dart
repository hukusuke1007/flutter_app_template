// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore_counter.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$firestoreCounterHash() => r'6df781dbbeb65270be655a4caaf5b15732c0f128';

/// See also [FirestoreCounter].
@ProviderFor(FirestoreCounter)
final firestoreCounterProvider =
    AutoDisposeAsyncNotifierProvider<FirestoreCounter, Counter?>.internal(
  FirestoreCounter.new,
  name: r'firestoreCounterProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$firestoreCounterHash,
  dependencies: <ProviderOrFamily>[
    authStateControllerProvider,
    firebaseAuthRepositoryProvider,
    documentRepositoryProvider
  ],
  allTransitiveDependencies: <ProviderOrFamily>{
    authStateControllerProvider,
    ...?authStateControllerProvider.allTransitiveDependencies,
    firebaseAuthRepositoryProvider,
    ...?firebaseAuthRepositoryProvider.allTransitiveDependencies,
    documentRepositoryProvider,
    ...?documentRepositoryProvider.allTransitiveDependencies
  },
);

typedef _$FirestoreCounter = AutoDisposeAsyncNotifier<Counter?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
