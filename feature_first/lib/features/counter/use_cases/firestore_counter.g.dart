// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore_counter.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FirestoreCounter)
const firestoreCounterProvider = FirestoreCounterProvider._();

final class FirestoreCounterProvider
    extends $AsyncNotifierProvider<FirestoreCounter, Counter?> {
  const FirestoreCounterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'firestoreCounterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$firestoreCounterHash();

  @$internal
  @override
  FirestoreCounter create() => FirestoreCounter();
}

String _$firestoreCounterHash() => r'7d4c20fea67498d90a0558ddbbd6e749ce82ecde';

abstract class _$FirestoreCounter extends $AsyncNotifier<Counter?> {
  FutureOr<Counter?> build();
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
