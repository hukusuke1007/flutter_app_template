// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screen_reader_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(screenReaderRepository)
const screenReaderRepositoryProvider = ScreenReaderRepositoryProvider._();

final class ScreenReaderRepositoryProvider
    extends
        $FunctionalProvider<
          ScreenReaderRepository,
          ScreenReaderRepository,
          ScreenReaderRepository
        >
    with $Provider<ScreenReaderRepository> {
  const ScreenReaderRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'screenReaderRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$screenReaderRepositoryHash();

  @$internal
  @override
  $ProviderElement<ScreenReaderRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ScreenReaderRepository create(Ref ref) {
    return screenReaderRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ScreenReaderRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ScreenReaderRepository>(value),
    );
  }
}

String _$screenReaderRepositoryHash() =>
    r'd72dd3017b3212998db3196ef6d6fac91b09c733';
