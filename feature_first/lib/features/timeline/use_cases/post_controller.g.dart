// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$postControllerHash() => r'8363d7ebb138dfef670cedce88930c19ca41ed3e';

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

abstract class _$PostController
    extends BuildlessAutoDisposeAsyncNotifier<Post?> {
  late final String? posterId;
  late final String? postId;

  Future<Post?> build({
    required String? posterId,
    required String? postId,
  });
}

/// See also [PostController].
@ProviderFor(PostController)
const postControllerProvider = PostControllerFamily();

/// See also [PostController].
class PostControllerFamily extends Family<AsyncValue<Post?>> {
  /// See also [PostController].
  const PostControllerFamily();

  /// See also [PostController].
  PostControllerProvider call({
    required String? posterId,
    required String? postId,
  }) {
    return PostControllerProvider(
      posterId: posterId,
      postId: postId,
    );
  }

  @override
  PostControllerProvider getProviderOverride(
    covariant PostControllerProvider provider,
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
  String? get name => r'postControllerProvider';
}

/// See also [PostController].
class PostControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<PostController, Post?> {
  /// See also [PostController].
  PostControllerProvider({
    required String? posterId,
    required String? postId,
  }) : this._internal(
          () => PostController()
            ..posterId = posterId
            ..postId = postId,
          from: postControllerProvider,
          name: r'postControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$postControllerHash,
          dependencies: PostControllerFamily._dependencies,
          allTransitiveDependencies:
              PostControllerFamily._allTransitiveDependencies,
          posterId: posterId,
          postId: postId,
        );

  PostControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.posterId,
    required this.postId,
  }) : super.internal();

  final String? posterId;
  final String? postId;

  @override
  Future<Post?> runNotifierBuild(
    covariant PostController notifier,
  ) {
    return notifier.build(
      posterId: posterId,
      postId: postId,
    );
  }

  @override
  Override overrideWith(PostController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PostControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<PostController, Post?>
      createElement() {
    return _PostControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PostControllerProvider &&
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

mixin PostControllerRef on AutoDisposeAsyncNotifierProviderRef<Post?> {
  /// The parameter `posterId` of this provider.
  String? get posterId;

  /// The parameter `postId` of this provider.
  String? get postId;
}

class _PostControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<PostController, Post?>
    with PostControllerRef {
  _PostControllerProviderElement(super.provider);

  @override
  String? get posterId => (origin as PostControllerProvider).posterId;
  @override
  String? get postId => (origin as PostControllerProvider).postId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
