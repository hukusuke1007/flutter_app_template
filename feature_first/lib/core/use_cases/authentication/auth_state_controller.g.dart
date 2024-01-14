// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_state_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authStateControllerHash() =>
    r'dc4d5001f1eacd2fe16f6f174ea0175623b9e5ae';

/// See also [AuthStateController].
@ProviderFor(AuthStateController)
final authStateControllerProvider =
    NotifierProvider<AuthStateController, AuthState>.internal(
  AuthStateController.new,
  name: r'authStateControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authStateControllerHash,
  dependencies: <ProviderOrFamily>[firebaseAuthRepositoryProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    firebaseAuthRepositoryProvider,
    ...?firebaseAuthRepositoryProvider.allTransitiveDependencies
  },
);

typedef _$AuthStateController = Notifier<AuthState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
