// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_users_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// GithubのユーザーリストをAsyncNotifierで管理する

@ProviderFor(GithubUsersController)
final githubUsersControllerProvider = GithubUsersControllerProvider._();

/// GithubのユーザーリストをAsyncNotifierで管理する
final class GithubUsersControllerProvider
    extends $AsyncNotifierProvider<GithubUsersController, List<User>> {
  /// GithubのユーザーリストをAsyncNotifierで管理する
  GithubUsersControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'githubUsersControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$githubUsersControllerHash();

  @$internal
  @override
  GithubUsersController create() => GithubUsersController();
}

String _$githubUsersControllerHash() =>
    r'd7834fef3e8b2660af6c3e31940707fa4e1804b1';

/// GithubのユーザーリストをAsyncNotifierで管理する

abstract class _$GithubUsersController extends $AsyncNotifier<List<User>> {
  FutureOr<List<User>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<User>>, List<User>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<User>>, List<User>>,
              AsyncValue<List<User>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
