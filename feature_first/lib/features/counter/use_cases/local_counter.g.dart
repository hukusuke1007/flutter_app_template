// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_counter.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LocalCounter)
const localCounterProvider = LocalCounterProvider._();

final class LocalCounterProvider extends $NotifierProvider<LocalCounter, int> {
  const LocalCounterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localCounterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localCounterHash();

  @$internal
  @override
  LocalCounter create() => LocalCounter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$localCounterHash() => r'aec790379baec50aef62d7fe870ae581941b59e9';

abstract class _$LocalCounter extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
