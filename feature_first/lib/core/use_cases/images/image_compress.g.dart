// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_compress.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(imageCompress)
const imageCompressProvider = ImageCompressProvider._();

final class ImageCompressProvider
    extends $FunctionalProvider<ImageCompress, ImageCompress, ImageCompress>
    with $Provider<ImageCompress> {
  const ImageCompressProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'imageCompressProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$imageCompressHash();

  @$internal
  @override
  $ProviderElement<ImageCompress> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ImageCompress create(Ref ref) {
    return imageCompress(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ImageCompress value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ImageCompress>(value),
    );
  }
}

String _$imageCompressHash() => r'95a4e18d840d9df1afed45a6216d163bef1f70d7';
