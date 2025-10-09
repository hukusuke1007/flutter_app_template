// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_api_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(githubApiRepository)
const githubApiRepositoryProvider = GithubApiRepositoryProvider._();

final class GithubApiRepositoryProvider
    extends
        $FunctionalProvider<
          GithubApiRepository,
          GithubApiRepository,
          GithubApiRepository
        >
    with $Provider<GithubApiRepository> {
  const GithubApiRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'githubApiRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$githubApiRepositoryHash();

  @$internal
  @override
  $ProviderElement<GithubApiRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GithubApiRepository create(Ref ref) {
    return githubApiRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GithubApiRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GithubApiRepository>(value),
    );
  }
}

String _$githubApiRepositoryHash() =>
    r'f9ccea515e069766f8bee98d9c9bfa757bd6cb9e';
