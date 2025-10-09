// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_state_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AuthStateController)
const authStateControllerProvider = AuthStateControllerProvider._();

final class AuthStateControllerProvider
    extends $NotifierProvider<AuthStateController, AuthState> {
  const AuthStateControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authStateControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authStateControllerHash();

  @$internal
  @override
  AuthStateController create() => AuthStateController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthState>(value),
    );
  }
}

String _$authStateControllerHash() =>
    r'fc1a72c20e51bcb29387fd006a0f38ad7a244dd5';

abstract class _$AuthStateController extends $Notifier<AuthState> {
  AuthState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AuthState, AuthState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AuthState, AuthState>,
              AuthState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
