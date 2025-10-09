// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(fileRepository)
const fileRepositoryProvider = FileRepositoryProvider._();

final class FileRepositoryProvider
    extends $FunctionalProvider<FileRepository, FileRepository, FileRepository>
    with $Provider<FileRepository> {
  const FileRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fileRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fileRepositoryHash();

  @$internal
  @override
  $ProviderElement<FileRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FileRepository create(Ref ref) {
    return fileRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FileRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FileRepository>(value),
    );
  }
}

String _$fileRepositoryHash() => r'e455678270274497fd0eb91aafc6d3422900b4e4';
