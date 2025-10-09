// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_my_profile_image.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(saveMyProfileImage)
const saveMyProfileImageProvider = SaveMyProfileImageProvider._();

final class SaveMyProfileImageProvider
    extends
        $FunctionalProvider<
          SaveMyProfileImage,
          SaveMyProfileImage,
          SaveMyProfileImage
        >
    with $Provider<SaveMyProfileImage> {
  const SaveMyProfileImageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'saveMyProfileImageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$saveMyProfileImageHash();

  @$internal
  @override
  $ProviderElement<SaveMyProfileImage> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SaveMyProfileImage create(Ref ref) {
    return saveMyProfileImage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SaveMyProfileImage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SaveMyProfileImage>(value),
    );
  }
}

String _$saveMyProfileImageHash() =>
    r'f246d142a570fb32c779a033c685ae69ebabc67f';
