// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_sum.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FetchSum)
const fetchSumProvider = FetchSumProvider._();

final class FetchSumProvider extends $AsyncNotifierProvider<FetchSum, double> {
  const FetchSumProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fetchSumProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fetchSumHash();

  @$internal
  @override
  FetchSum create() => FetchSum();
}

String _$fetchSumHash() => r'c7ac0c582dbccba1979d14a4674437e13c5c7fd6';

abstract class _$FetchSum extends $AsyncNotifier<double> {
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
