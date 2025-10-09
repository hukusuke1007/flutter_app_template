// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'memo_controller.dart';

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
          CollectionPagingRepository<Memo>,
          CollectionPagingRepository<Memo>,
          CollectionPagingRepository<Memo>
        >
    with $Provider<CollectionPagingRepository<Memo>> {
  const CollectionPagingRepositoryProvider._({
    required CollectionPagingRepositoryFamily super.from,
    required CollectionParam<Memo> super.argument,
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
  $ProviderElement<CollectionPagingRepository<Memo>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CollectionPagingRepository<Memo> create(Ref ref) {
    final argument = this.argument as CollectionParam<Memo>;
    return collectionPagingRepository(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CollectionPagingRepository<Memo> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CollectionPagingRepository<Memo>>(
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
    r'5a723ec6cb9ff565e86138fea8ceec5ca902dee4';

final class CollectionPagingRepositoryFamily extends $Family
    with
        $FunctionalFamilyOverride<
          CollectionPagingRepository<Memo>,
          CollectionParam<Memo>
        > {
  const CollectionPagingRepositoryFamily._()
    : super(
        retry: null,
        name: r'collectionPagingRepositoryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CollectionPagingRepositoryProvider call(CollectionParam<Memo> query) =>
      CollectionPagingRepositoryProvider._(argument: query, from: this);

  @override
  String toString() => r'collectionPagingRepositoryProvider';
}

@ProviderFor(MemoController)
const memoControllerProvider = MemoControllerProvider._();

final class MemoControllerProvider
    extends $AsyncNotifierProvider<MemoController, List<Memo>> {
  const MemoControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'memoControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$memoControllerHash();

  @$internal
  @override
  MemoController create() => MemoController();
}

String _$memoControllerHash() => r'73fe90b8abd448ef0e3ac42179174e959b493535';

abstract class _$MemoController extends $AsyncNotifier<List<Memo>> {
  FutureOr<List<Memo>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<Memo>>, List<Memo>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Memo>>, List<Memo>>,
              AsyncValue<List<Memo>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
