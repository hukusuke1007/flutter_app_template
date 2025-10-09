// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_logger.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(analyticsLogger)
const analyticsLoggerProvider = AnalyticsLoggerProvider._();

final class AnalyticsLoggerProvider
    extends
        $FunctionalProvider<AnalyticsLogger, AnalyticsLogger, AnalyticsLogger>
    with $Provider<AnalyticsLogger> {
  const AnalyticsLoggerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'analyticsLoggerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$analyticsLoggerHash();

  @$internal
  @override
  $ProviderElement<AnalyticsLogger> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AnalyticsLogger create(Ref ref) {
    return analyticsLogger(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AnalyticsLogger value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AnalyticsLogger>(value),
    );
  }
}

String _$analyticsLoggerHash() => r'e280d857df93af81985c4071a7caabb3c3e5e454';
