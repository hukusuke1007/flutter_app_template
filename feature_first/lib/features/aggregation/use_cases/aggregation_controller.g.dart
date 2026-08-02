// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aggregation_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AggregationController)
final aggregationControllerProvider = AggregationControllerProvider._();

final class AggregationControllerProvider
    extends $AsyncNotifierProvider<AggregationController, List<Result>> {
  AggregationControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'aggregationControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$aggregationControllerHash();

  @$internal
  @override
  AggregationController create() => AggregationController();
}

String _$aggregationControllerHash() =>
    r'82d51251f367fa702fc765b337e537dccb350fd7';

abstract class _$AggregationController extends $AsyncNotifier<List<Result>> {
  FutureOr<List<Result>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Result>>, List<Result>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Result>>, List<Result>>,
              AsyncValue<List<Result>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
