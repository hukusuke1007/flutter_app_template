// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_aggregation.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FetchAggregation)
final fetchAggregationProvider = FetchAggregationProvider._();

final class FetchAggregationProvider
    extends $AsyncNotifierProvider<FetchAggregation, Result> {
  FetchAggregationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fetchAggregationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fetchAggregationHash();

  @$internal
  @override
  FetchAggregation create() => FetchAggregation();
}

String _$fetchAggregationHash() => r'501f7c5de8450cb7d1d4bf843544ca4b3988fb77';

abstract class _$FetchAggregation extends $AsyncNotifier<Result> {
  FutureOr<Result> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Result>, Result>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Result>, Result>,
              AsyncValue<Result>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
