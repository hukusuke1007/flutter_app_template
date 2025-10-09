// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_firestore_counter_stream.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 取得（スナップショットリスナー使用）

@ProviderFor(FetchFirestoreCounter)
const fetchFirestoreCounterProvider = FetchFirestoreCounterProvider._();

/// 取得（スナップショットリスナー使用）
final class FetchFirestoreCounterProvider
    extends $StreamNotifierProvider<FetchFirestoreCounter, Counter?> {
  /// 取得（スナップショットリスナー使用）
  const FetchFirestoreCounterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fetchFirestoreCounterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fetchFirestoreCounterHash();

  @$internal
  @override
  FetchFirestoreCounter create() => FetchFirestoreCounter();
}

String _$fetchFirestoreCounterHash() =>
    r'9554f5ddc96253a464078be15f81ec371dc0fb7d';

/// 取得（スナップショットリスナー使用）

abstract class _$FetchFirestoreCounter extends $StreamNotifier<Counter?> {
  Stream<Counter?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<Counter?>, Counter?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Counter?>, Counter?>,
              AsyncValue<Counter?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
