// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_timeline.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(collectionPagingRepository)
const collectionPagingRepositoryProvider = CollectionPagingRepositoryFamily._();

final class CollectionPagingRepositoryProvider
    extends
        $FunctionalProvider<
          CollectionPagingRepository<Post>,
          CollectionPagingRepository<Post>,
          CollectionPagingRepository<Post>
        >
    with $Provider<CollectionPagingRepository<Post>> {
  const CollectionPagingRepositoryProvider._({
    required CollectionPagingRepositoryFamily super.from,
    required CollectionParam<Post> super.argument,
  }) : super(
         retry: null,
         name: r'collectionPagingRepositoryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$collectionPagingRepositoryHash();

  @override
  String toString() {
    return r'collectionPagingRepositoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<CollectionPagingRepository<Post>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CollectionPagingRepository<Post> create(Ref ref) {
    final argument = this.argument as CollectionParam<Post>;
    return collectionPagingRepository(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CollectionPagingRepository<Post> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CollectionPagingRepository<Post>>(
        value,
      ),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CollectionPagingRepositoryProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$collectionPagingRepositoryHash() =>
    r'140f05754040e904844c858736c19232beac6fe7';

final class CollectionPagingRepositoryFamily extends $Family
    with
        $FunctionalFamilyOverride<
          CollectionPagingRepository<Post>,
          CollectionParam<Post>
        > {
  const CollectionPagingRepositoryFamily._()
    : super(
        retry: null,
        name: r'collectionPagingRepositoryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CollectionPagingRepositoryProvider call(CollectionParam<Post> query) =>
      CollectionPagingRepositoryProvider._(argument: query, from: this);

  @override
  String toString() => r'collectionPagingRepositoryProvider';
}

/// タイムラインを取得

@ProviderFor(FetchTimeline)
const fetchTimelineProvider = FetchTimelineProvider._();

/// タイムラインを取得
final class FetchTimelineProvider
    extends $AsyncNotifierProvider<FetchTimeline, List<Post>> {
  /// タイムラインを取得
  const FetchTimelineProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fetchTimelineProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fetchTimelineHash();

  @$internal
  @override
  FetchTimeline create() => FetchTimeline();
}

String _$fetchTimelineHash() => r'3e99741b4dff55efb11af95797cd180ebc46514a';

/// タイムラインを取得

abstract class _$FetchTimeline extends $AsyncNotifier<List<Post>> {
  FutureOr<List<Post>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<Post>>, List<Post>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Post>>, List<Post>>,
              AsyncValue<List<Post>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
