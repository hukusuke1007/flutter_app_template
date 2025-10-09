// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_poster.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 投稿者を取得

@ProviderFor(FetchPoster)
const fetchPosterProvider = FetchPosterFamily._();

/// 投稿者を取得
final class FetchPosterProvider
    extends $AsyncNotifierProvider<FetchPoster, Developer?> {
  /// 投稿者を取得
  const FetchPosterProvider._({
    required FetchPosterFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'fetchPosterProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$fetchPosterHash();

  @override
  String toString() {
    return r'fetchPosterProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  FetchPoster create() => FetchPoster();

  @override
  bool operator ==(Object other) {
    return other is FetchPosterProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchPosterHash() => r'b7b9b5dd38daec8fd9ac6cd745d552395d0b902b';

/// 投稿者を取得

final class FetchPosterFamily extends $Family
    with
        $ClassFamilyOverride<
          FetchPoster,
          AsyncValue<Developer?>,
          Developer?,
          FutureOr<Developer?>,
          String
        > {
  const FetchPosterFamily._()
    : super(
        retry: null,
        name: r'fetchPosterProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// 投稿者を取得

  FetchPosterProvider call(String userId) =>
      FetchPosterProvider._(argument: userId, from: this);

  @override
  String toString() => r'fetchPosterProvider';
}

/// 投稿者を取得

abstract class _$FetchPoster extends $AsyncNotifier<Developer?> {
  late final _$args = ref.$arg as String;
  String get userId => _$args;

  FutureOr<Developer?> build(String userId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<Developer?>, Developer?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Developer?>, Developer?>,
              AsyncValue<Developer?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// 投稿者を取得（スナップショットリスナー使用）

@ProviderFor(FetchPosterStream)
const fetchPosterStreamProvider = FetchPosterStreamFamily._();

/// 投稿者を取得（スナップショットリスナー使用）
final class FetchPosterStreamProvider
    extends $StreamNotifierProvider<FetchPosterStream, Developer?> {
  /// 投稿者を取得（スナップショットリスナー使用）
  const FetchPosterStreamProvider._({
    required FetchPosterStreamFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'fetchPosterStreamProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$fetchPosterStreamHash();

  @override
  String toString() {
    return r'fetchPosterStreamProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  FetchPosterStream create() => FetchPosterStream();

  @override
  bool operator ==(Object other) {
    return other is FetchPosterStreamProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchPosterStreamHash() => r'da0d5d761af295337309129f779ea32e794b5ee7';

/// 投稿者を取得（スナップショットリスナー使用）

final class FetchPosterStreamFamily extends $Family
    with
        $ClassFamilyOverride<
          FetchPosterStream,
          AsyncValue<Developer?>,
          Developer?,
          Stream<Developer?>,
          String
        > {
  const FetchPosterStreamFamily._()
    : super(
        retry: null,
        name: r'fetchPosterStreamProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// 投稿者を取得（スナップショットリスナー使用）

  FetchPosterStreamProvider call(String userId) =>
      FetchPosterStreamProvider._(argument: userId, from: this);

  @override
  String toString() => r'fetchPosterStreamProvider';
}

/// 投稿者を取得（スナップショットリスナー使用）

abstract class _$FetchPosterStream extends $StreamNotifier<Developer?> {
  late final _$args = ref.$arg as String;
  String get userId => _$args;

  Stream<Developer?> build(String userId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<Developer?>, Developer?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Developer?>, Developer?>,
              AsyncValue<Developer?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
