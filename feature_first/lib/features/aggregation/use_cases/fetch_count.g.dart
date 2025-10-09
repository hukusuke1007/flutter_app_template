// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_count.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FetchCount)
const fetchCountProvider = FetchCountProvider._();

final class FetchCountProvider extends $AsyncNotifierProvider<FetchCount, int> {
  const FetchCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fetchCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fetchCountHash();

  @$internal
  @override
  FetchCount create() => FetchCount();
}

String _$fetchCountHash() => r'914ae2fb28417fe8ab1c1c7bc87d800657f7b58d';

abstract class _$FetchCount extends $AsyncNotifier<int> {
  FutureOr<int> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<int>, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<int>, int>,
              AsyncValue<int>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
