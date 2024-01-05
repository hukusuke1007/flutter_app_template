// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_timeline.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$collectionPagingRepositoryHash() =>
    r'397ee1da22aa096f649e427562cfc16b69ec8c26';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [collectionPagingRepository].
@ProviderFor(collectionPagingRepository)
const collectionPagingRepositoryProvider = CollectionPagingRepositoryFamily();

/// See also [collectionPagingRepository].
class CollectionPagingRepositoryFamily
    extends Family<CollectionPagingRepository<Post>> {
  /// See also [collectionPagingRepository].
  const CollectionPagingRepositoryFamily();

  /// See also [collectionPagingRepository].
  CollectionPagingRepositoryProvider call(
    CollectionParam<Post> query,
  ) {
    return CollectionPagingRepositoryProvider(
      query,
    );
  }

  @override
  CollectionPagingRepositoryProvider getProviderOverride(
    covariant CollectionPagingRepositoryProvider provider,
  ) {
    return call(
      provider.query,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'collectionPagingRepositoryProvider';
}

/// See also [collectionPagingRepository].
class CollectionPagingRepositoryProvider
    extends AutoDisposeProvider<CollectionPagingRepository<Post>> {
  /// See also [collectionPagingRepository].
  CollectionPagingRepositoryProvider(
    CollectionParam<Post> query,
  ) : this._internal(
          (ref) => collectionPagingRepository(
            ref as CollectionPagingRepositoryRef,
            query,
          ),
          from: collectionPagingRepositoryProvider,
          name: r'collectionPagingRepositoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$collectionPagingRepositoryHash,
          dependencies: CollectionPagingRepositoryFamily._dependencies,
          allTransitiveDependencies:
              CollectionPagingRepositoryFamily._allTransitiveDependencies,
          query: query,
        );

  CollectionPagingRepositoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.query,
  }) : super.internal();

  final CollectionParam<Post> query;

  @override
  Override overrideWith(
    CollectionPagingRepository<Post> Function(
            CollectionPagingRepositoryRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CollectionPagingRepositoryProvider._internal(
        (ref) => create(ref as CollectionPagingRepositoryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        query: query,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<CollectionPagingRepository<Post>> createElement() {
    return _CollectionPagingRepositoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CollectionPagingRepositoryProvider && other.query == query;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, query.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CollectionPagingRepositoryRef
    on AutoDisposeProviderRef<CollectionPagingRepository<Post>> {
  /// The parameter `query` of this provider.
  CollectionParam<Post> get query;
}

class _CollectionPagingRepositoryProviderElement
    extends AutoDisposeProviderElement<CollectionPagingRepository<Post>>
    with CollectionPagingRepositoryRef {
  _CollectionPagingRepositoryProviderElement(super.provider);

  @override
  CollectionParam<Post> get query =>
      (origin as CollectionPagingRepositoryProvider).query;
}

String _$fetchTimelineHash() => r'ebe99d7c0047e370b8223574bb8d3fbecbc6341a';

/// タイムラインを取得
///
/// Copied from [FetchTimeline].
@ProviderFor(FetchTimeline)
final fetchTimelineProvider =
    AutoDisposeAsyncNotifierProvider<FetchTimeline, List<Post>>.internal(
  FetchTimeline.new,
  name: r'fetchTimelineProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchTimelineHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FetchTimeline = AutoDisposeAsyncNotifier<List<Post>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
