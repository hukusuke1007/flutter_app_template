// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_post.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchPostHash() => r'fa46d3dbbf3e9721e1e53e7fed8d1746776fffc9';

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

abstract class _$FetchPost extends BuildlessAutoDisposeAsyncNotifier<Post?> {
  late final String posterId;
  late final String postId;

  FutureOr<Post?> build({
    required String posterId,
    required String postId,
  });
}

/// 投稿を取得
///
/// Copied from [FetchPost].
@ProviderFor(FetchPost)
const fetchPostProvider = FetchPostFamily();

/// 投稿を取得
///
/// Copied from [FetchPost].
class FetchPostFamily extends Family<AsyncValue<Post?>> {
  /// 投稿を取得
  ///
  /// Copied from [FetchPost].
  const FetchPostFamily();

  /// 投稿を取得
  ///
  /// Copied from [FetchPost].
  FetchPostProvider call({
    required String posterId,
    required String postId,
  }) {
    return FetchPostProvider(
      posterId: posterId,
      postId: postId,
    );
  }

  @override
  FetchPostProvider getProviderOverride(
    covariant FetchPostProvider provider,
  ) {
    return call(
      posterId: provider.posterId,
      postId: provider.postId,
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
  String? get name => r'fetchPostProvider';
}

/// 投稿を取得
///
/// Copied from [FetchPost].
class FetchPostProvider
    extends AutoDisposeAsyncNotifierProviderImpl<FetchPost, Post?> {
  /// 投稿を取得
  ///
  /// Copied from [FetchPost].
  FetchPostProvider({
    required String posterId,
    required String postId,
  }) : this._internal(
          () => FetchPost()
            ..posterId = posterId
            ..postId = postId,
          from: fetchPostProvider,
          name: r'fetchPostProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchPostHash,
          dependencies: FetchPostFamily._dependencies,
          allTransitiveDependencies: FetchPostFamily._allTransitiveDependencies,
          posterId: posterId,
          postId: postId,
        );

  FetchPostProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.posterId,
    required this.postId,
  }) : super.internal();

  final String posterId;
  final String postId;

  @override
  FutureOr<Post?> runNotifierBuild(
    covariant FetchPost notifier,
  ) {
    return notifier.build(
      posterId: posterId,
      postId: postId,
    );
  }

  @override
  Override overrideWith(FetchPost Function() create) {
    return ProviderOverride(
      origin: this,
      override: FetchPostProvider._internal(
        () => create()
          ..posterId = posterId
          ..postId = postId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        posterId: posterId,
        postId: postId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<FetchPost, Post?> createElement() {
    return _FetchPostProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchPostProvider &&
        other.posterId == posterId &&
        other.postId == postId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, posterId.hashCode);
    hash = _SystemHash.combine(hash, postId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FetchPostRef on AutoDisposeAsyncNotifierProviderRef<Post?> {
  /// The parameter `posterId` of this provider.
  String get posterId;

  /// The parameter `postId` of this provider.
  String get postId;
}

class _FetchPostProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<FetchPost, Post?>
    with FetchPostRef {
  _FetchPostProviderElement(super.provider);

  @override
  String get posterId => (origin as FetchPostProvider).posterId;
  @override
  String get postId => (origin as FetchPostProvider).postId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
