// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_average.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FetchAverage)
const fetchAverageProvider = FetchAverageProvider._();

final class FetchAverageProvider
    extends $AsyncNotifierProvider<FetchAverage, double> {
  const FetchAverageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fetchAverageProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fetchAverageHash();

  @$internal
  @override
  FetchAverage create() => FetchAverage();
}

String _$fetchAverageHash() => r'e790f7612ef71b5f0dc063c19e03025bb7f0cdd3';

abstract class _$FetchAverage extends $AsyncNotifier<double> {
  FutureOr<double> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<double>, double>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<double>, double>,
              AsyncValue<double>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
