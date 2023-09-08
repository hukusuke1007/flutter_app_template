// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_post.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchPostHash() => r'0499d5ecc3ea8c0db52fccee50c7a56f7c2b276b';

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
  late final FetchPostArgs arg;

  FutureOr<Post?> build(
    FetchPostArgs arg,
  );
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
  FetchPostProvider call(
    FetchPostArgs arg,
  ) {
    return FetchPostProvider(
      arg,
    );
  }

  @override
  FetchPostProvider getProviderOverride(
    covariant FetchPostProvider provider,
  ) {
    return call(
      provider.arg,
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
  FetchPostProvider(
    FetchPostArgs arg,
  ) : this._internal(
          () => FetchPost()..arg = arg,
          from: fetchPostProvider,
          name: r'fetchPostProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchPostHash,
          dependencies: FetchPostFamily._dependencies,
          allTransitiveDependencies: FetchPostFamily._allTransitiveDependencies,
          arg: arg,
        );

  FetchPostProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.arg,
  }) : super.internal();

  final FetchPostArgs arg;

  @override
  FutureOr<Post?> runNotifierBuild(
    covariant FetchPost notifier,
  ) {
    return notifier.build(
      arg,
    );
  }

  @override
  Override overrideWith(FetchPost Function() create) {
    return ProviderOverride(
      origin: this,
      override: FetchPostProvider._internal(
        () => create()..arg = arg,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        arg: arg,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<FetchPost, Post?> createElement() {
    return _FetchPostProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchPostProvider && other.arg == arg;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, arg.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FetchPostRef on AutoDisposeAsyncNotifierProviderRef<Post?> {
  /// The parameter `arg` of this provider.
  FetchPostArgs get arg;
}

class _FetchPostProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<FetchPost, Post?>
    with FetchPostRef {
  _FetchPostProviderElement(super.provider);

  @override
  FetchPostArgs get arg => (origin as FetchPostProvider).arg;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
