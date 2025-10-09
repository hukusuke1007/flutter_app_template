// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_enable_screen_reader.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FetchEnableScreenReader)
const fetchEnableScreenReaderProvider = FetchEnableScreenReaderProvider._();

final class FetchEnableScreenReaderProvider
    extends $StreamNotifierProvider<FetchEnableScreenReader, bool> {
  const FetchEnableScreenReaderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fetchEnableScreenReaderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fetchEnableScreenReaderHash();

  @$internal
  @override
  FetchEnableScreenReader create() => FetchEnableScreenReader();
}

String _$fetchEnableScreenReaderHash() =>
    r'23d688b0e67ac73e0060fd9743063b1991c14458';

abstract class _$FetchEnableScreenReader extends $StreamNotifier<bool> {
  Stream<bool> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool>, bool>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
