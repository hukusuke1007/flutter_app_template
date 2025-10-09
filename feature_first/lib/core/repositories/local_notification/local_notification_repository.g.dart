// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_notification_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(localNotificationRepository)
const localNotificationRepositoryProvider =
    LocalNotificationRepositoryProvider._();

final class LocalNotificationRepositoryProvider
    extends
        $FunctionalProvider<
          LocalNotificationRepository,
          LocalNotificationRepository,
          LocalNotificationRepository
        >
    with $Provider<LocalNotificationRepository> {
  const LocalNotificationRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localNotificationRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localNotificationRepositoryHash();

  @$internal
  @override
  $ProviderElement<LocalNotificationRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  LocalNotificationRepository create(Ref ref) {
    return localNotificationRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LocalNotificationRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LocalNotificationRepository>(value),
    );
  }
}

String _$localNotificationRepositoryHash() =>
    r'f053033520e7603eaf706af3db74d78c9dc25b6b';
