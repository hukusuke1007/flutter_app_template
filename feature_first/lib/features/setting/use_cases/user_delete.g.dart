// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_delete.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userDelete)
const userDeleteProvider = UserDeleteProvider._();

final class UserDeleteProvider
    extends $FunctionalProvider<UserDelete, UserDelete, UserDelete>
    with $Provider<UserDelete> {
  const UserDeleteProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userDeleteProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userDeleteHash();

  @$internal
  @override
  $ProviderElement<UserDelete> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UserDelete create(Ref ref) {
    return userDelete(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserDelete value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserDelete>(value),
    );
  }
}

String _$userDeleteHash() => r'2dfe202a78f5e49b46f6b763968e57544684ed5a';
