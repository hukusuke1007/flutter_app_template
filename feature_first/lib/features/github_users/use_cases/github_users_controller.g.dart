// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_users_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$githubUsersControllerHash() =>
    r'd7834fef3e8b2660af6c3e31940707fa4e1804b1';

/// GithubのユーザーリストをAsyncNotifierで管理する
///
/// Copied from [GithubUsersController].
@ProviderFor(GithubUsersController)
final githubUsersControllerProvider = AutoDisposeAsyncNotifierProvider<
  GithubUsersController,
  List<User>
>.internal(
  GithubUsersController.new,
  name: r'githubUsersControllerProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$githubUsersControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GithubUsersController = AutoDisposeAsyncNotifier<List<User>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
