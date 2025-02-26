// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_poster.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchPosterHash() => r'b7b9b5dd38daec8fd9ac6cd745d552395d0b902b';

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

abstract class _$FetchPoster
    extends BuildlessAutoDisposeAsyncNotifier<Developer?> {
  late final String userId;

  FutureOr<Developer?> build(
    String userId,
  );
}

/// 投稿者を取得
///
/// Copied from [FetchPoster].
@ProviderFor(FetchPoster)
const fetchPosterProvider = FetchPosterFamily();

/// 投稿者を取得
///
/// Copied from [FetchPoster].
class FetchPosterFamily extends Family<AsyncValue<Developer?>> {
  /// 投稿者を取得
  ///
  /// Copied from [FetchPoster].
  const FetchPosterFamily();

  /// 投稿者を取得
  ///
  /// Copied from [FetchPoster].
  FetchPosterProvider call(
    String userId,
  ) {
    return FetchPosterProvider(
      userId,
    );
  }

  @override
  FetchPosterProvider getProviderOverride(
    covariant FetchPosterProvider provider,
  ) {
    return call(
      provider.userId,
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
  String? get name => r'fetchPosterProvider';
}

/// 投稿者を取得
///
/// Copied from [FetchPoster].
class FetchPosterProvider
    extends AutoDisposeAsyncNotifierProviderImpl<FetchPoster, Developer?> {
  /// 投稿者を取得
  ///
  /// Copied from [FetchPoster].
  FetchPosterProvider(
    String userId,
  ) : this._internal(
          () => FetchPoster()..userId = userId,
          from: fetchPosterProvider,
          name: r'fetchPosterProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchPosterHash,
          dependencies: FetchPosterFamily._dependencies,
          allTransitiveDependencies:
              FetchPosterFamily._allTransitiveDependencies,
          userId: userId,
        );

  FetchPosterProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  FutureOr<Developer?> runNotifierBuild(
    covariant FetchPoster notifier,
  ) {
    return notifier.build(
      userId,
    );
  }

  @override
  Override overrideWith(FetchPoster Function() create) {
    return ProviderOverride(
      origin: this,
      override: FetchPosterProvider._internal(
        () => create()..userId = userId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<FetchPoster, Developer?>
      createElement() {
    return _FetchPosterProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchPosterProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FetchPosterRef on AutoDisposeAsyncNotifierProviderRef<Developer?> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _FetchPosterProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<FetchPoster, Developer?>
    with FetchPosterRef {
  _FetchPosterProviderElement(super.provider);

  @override
  String get userId => (origin as FetchPosterProvider).userId;
}

String _$fetchPosterStreamHash() => r'da0d5d761af295337309129f779ea32e794b5ee7';

abstract class _$FetchPosterStream
    extends BuildlessAutoDisposeStreamNotifier<Developer?> {
  late final String userId;

  Stream<Developer?> build(
    String userId,
  );
}

/// 投稿者を取得（スナップショットリスナー使用）
///
/// Copied from [FetchPosterStream].
@ProviderFor(FetchPosterStream)
const fetchPosterStreamProvider = FetchPosterStreamFamily();

/// 投稿者を取得（スナップショットリスナー使用）
///
/// Copied from [FetchPosterStream].
class FetchPosterStreamFamily extends Family<AsyncValue<Developer?>> {
  /// 投稿者を取得（スナップショットリスナー使用）
  ///
  /// Copied from [FetchPosterStream].
  const FetchPosterStreamFamily();

  /// 投稿者を取得（スナップショットリスナー使用）
  ///
  /// Copied from [FetchPosterStream].
  FetchPosterStreamProvider call(
    String userId,
  ) {
    return FetchPosterStreamProvider(
      userId,
    );
  }

  @override
  FetchPosterStreamProvider getProviderOverride(
    covariant FetchPosterStreamProvider provider,
  ) {
    return call(
      provider.userId,
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
  String? get name => r'fetchPosterStreamProvider';
}

/// 投稿者を取得（スナップショットリスナー使用）
///
/// Copied from [FetchPosterStream].
class FetchPosterStreamProvider extends AutoDisposeStreamNotifierProviderImpl<
    FetchPosterStream, Developer?> {
  /// 投稿者を取得（スナップショットリスナー使用）
  ///
  /// Copied from [FetchPosterStream].
  FetchPosterStreamProvider(
    String userId,
  ) : this._internal(
          () => FetchPosterStream()..userId = userId,
          from: fetchPosterStreamProvider,
          name: r'fetchPosterStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchPosterStreamHash,
          dependencies: FetchPosterStreamFamily._dependencies,
          allTransitiveDependencies:
              FetchPosterStreamFamily._allTransitiveDependencies,
          userId: userId,
        );

  FetchPosterStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Stream<Developer?> runNotifierBuild(
    covariant FetchPosterStream notifier,
  ) {
    return notifier.build(
      userId,
    );
  }

  @override
  Override overrideWith(FetchPosterStream Function() create) {
    return ProviderOverride(
      origin: this,
      override: FetchPosterStreamProvider._internal(
        () => create()..userId = userId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeStreamNotifierProviderElement<FetchPosterStream, Developer?>
      createElement() {
    return _FetchPosterStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchPosterStreamProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FetchPosterStreamRef on AutoDisposeStreamNotifierProviderRef<Developer?> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _FetchPosterStreamProviderElement
    extends AutoDisposeStreamNotifierProviderElement<FetchPosterStream,
        Developer?> with FetchPosterStreamRef {
  _FetchPosterStreamProviderElement(super.provider);

  @override
  String get userId => (origin as FetchPosterStreamProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
