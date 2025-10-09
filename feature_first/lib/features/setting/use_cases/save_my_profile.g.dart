// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_my_profile.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(saveMyProfile)
const saveMyProfileProvider = SaveMyProfileProvider._();

final class SaveMyProfileProvider
    extends $FunctionalProvider<SaveMyProfile, SaveMyProfile, SaveMyProfile>
    with $Provider<SaveMyProfile> {
  const SaveMyProfileProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'saveMyProfileProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$saveMyProfileHash();

  @$internal
  @override
  $ProviderElement<SaveMyProfile> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SaveMyProfile create(Ref ref) {
    return saveMyProfile(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SaveMyProfile value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SaveMyProfile>(value),
    );
  }
}

String _$saveMyProfileHash() => r'01b72965ecb9a1ed7a3d0f55ab0f6d3bb4c47bad';
