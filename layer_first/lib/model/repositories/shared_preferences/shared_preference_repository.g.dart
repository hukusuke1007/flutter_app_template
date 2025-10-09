// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_preference_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(sharedPreferencesRepository)
const sharedPreferencesRepositoryProvider =
    SharedPreferencesRepositoryProvider._();

final class SharedPreferencesRepositoryProvider
    extends
        $FunctionalProvider<
          SharedPreferencesRepository,
          SharedPreferencesRepository,
          SharedPreferencesRepository
        >
    with $Provider<SharedPreferencesRepository> {
  const SharedPreferencesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sharedPreferencesRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sharedPreferencesRepositoryHash();

  @$internal
  @override
  $ProviderElement<SharedPreferencesRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SharedPreferencesRepository create(Ref ref) {
    return sharedPreferencesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SharedPreferencesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SharedPreferencesRepository>(value),
    );
  }
}

String _$sharedPreferencesRepositoryHash() =>
    r'08a1b756abe0325908f56bffdc13219c6b786102';
