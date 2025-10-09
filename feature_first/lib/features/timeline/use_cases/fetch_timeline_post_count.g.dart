// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_timeline_post_count.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// タイムラインの投稿数を取得

@ProviderFor(fetchTimelinePostCount)
const fetchTimelinePostCountProvider = FetchTimelinePostCountProvider._();

/// タイムラインの投稿数を取得

final class FetchTimelinePostCountProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  /// タイムラインの投稿数を取得
  const FetchTimelinePostCountProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fetchTimelinePostCountProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fetchTimelinePostCountHash();

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    return fetchTimelinePostCount(ref);
  }
}

String _$fetchTimelinePostCountHash() =>
    r'6029f02d750f7369836a8cd69d31ab6a939964c8';
