// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_with_anonymously.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(signInWithAnonymously)
const signInWithAnonymouslyProvider = SignInWithAnonymouslyProvider._();

final class SignInWithAnonymouslyProvider
    extends
        $FunctionalProvider<
          SignInWithAnonymously,
          SignInWithAnonymously,
          SignInWithAnonymously
        >
    with $Provider<SignInWithAnonymously> {
  const SignInWithAnonymouslyProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'signInWithAnonymouslyProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$signInWithAnonymouslyHash();

  @$internal
  @override
  $ProviderElement<SignInWithAnonymously> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SignInWithAnonymously create(Ref ref) {
    return signInWithAnonymously(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SignInWithAnonymously value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SignInWithAnonymously>(value),
    );
  }
}

String _$signInWithAnonymouslyHash() =>
    r'd62b41fe6d199b181925f98564f2fb3e133e14b5';
