// Mocks generated by Mockito 5.4.5 from annotations
// in flutter_app_template/test/features/authentication/use_cases/sign_in_with_email_and_password_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:firebase_auth/firebase_auth.dart' as _i2;
import 'package:flutter_app_template/core/repositories/firebase_auth/firebase_auth_repository.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeUserCredential_0 extends _i1.SmartFake
    implements _i2.UserCredential {
  _FakeUserCredential_0(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

/// A class which mocks [FirebaseAuthRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockFirebaseAuthRepository extends _i1.Mock
    implements _i3.FirebaseAuthRepository {
  @override
  _i4.Stream<_i2.User?> get onAuthStateChanged =>
      (super.noSuchMethod(
            Invocation.getter(#onAuthStateChanged),
            returnValue: _i4.Stream<_i2.User?>.empty(),
            returnValueForMissingStub: _i4.Stream<_i2.User?>.empty(),
          )
          as _i4.Stream<_i2.User?>);

  @override
  _i4.Stream<_i2.User?> get onUserChanged =>
      (super.noSuchMethod(
            Invocation.getter(#onUserChanged),
            returnValue: _i4.Stream<_i2.User?>.empty(),
            returnValueForMissingStub: _i4.Stream<_i2.User?>.empty(),
          )
          as _i4.Stream<_i2.User?>);

  @override
  bool get isAnonymously =>
      (super.noSuchMethod(
            Invocation.getter(#isAnonymously),
            returnValue: false,
            returnValueForMissingStub: false,
          )
          as bool);

  @override
  bool get isEmailVerified =>
      (super.noSuchMethod(
            Invocation.getter(#isEmailVerified),
            returnValue: false,
            returnValueForMissingStub: false,
          )
          as bool);

  @override
  _i4.Future<String?> get idToken =>
      (super.noSuchMethod(
            Invocation.getter(#idToken),
            returnValue: _i4.Future<String?>.value(),
            returnValueForMissingStub: _i4.Future<String?>.value(),
          )
          as _i4.Future<String?>);

  @override
  _i4.Future<_i2.UserCredential> signInWithAnonymously() =>
      (super.noSuchMethod(
            Invocation.method(#signInWithAnonymously, []),
            returnValue: _i4.Future<_i2.UserCredential>.value(
              _FakeUserCredential_0(
                this,
                Invocation.method(#signInWithAnonymously, []),
              ),
            ),
            returnValueForMissingStub: _i4.Future<_i2.UserCredential>.value(
              _FakeUserCredential_0(
                this,
                Invocation.method(#signInWithAnonymously, []),
              ),
            ),
          )
          as _i4.Future<_i2.UserCredential>);

  @override
  _i4.Future<_i2.UserCredential> signInWithAuthCredential(
    _i2.AuthCredential? authCredential,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#signInWithAuthCredential, [authCredential]),
            returnValue: _i4.Future<_i2.UserCredential>.value(
              _FakeUserCredential_0(
                this,
                Invocation.method(#signInWithAuthCredential, [authCredential]),
              ),
            ),
            returnValueForMissingStub: _i4.Future<_i2.UserCredential>.value(
              _FakeUserCredential_0(
                this,
                Invocation.method(#signInWithAuthCredential, [authCredential]),
              ),
            ),
          )
          as _i4.Future<_i2.UserCredential>);

  @override
  _i4.Future<_i2.UserCredential> createUserWithEmailAndPassword(
    String? email,
    String? password,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#createUserWithEmailAndPassword, [
              email,
              password,
            ]),
            returnValue: _i4.Future<_i2.UserCredential>.value(
              _FakeUserCredential_0(
                this,
                Invocation.method(#createUserWithEmailAndPassword, [
                  email,
                  password,
                ]),
              ),
            ),
            returnValueForMissingStub: _i4.Future<_i2.UserCredential>.value(
              _FakeUserCredential_0(
                this,
                Invocation.method(#createUserWithEmailAndPassword, [
                  email,
                  password,
                ]),
              ),
            ),
          )
          as _i4.Future<_i2.UserCredential>);

  @override
  _i4.Future<_i2.UserCredential> signInWithEmailAndPassword(
    String? email,
    String? password,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#signInWithEmailAndPassword, [email, password]),
            returnValue: _i4.Future<_i2.UserCredential>.value(
              _FakeUserCredential_0(
                this,
                Invocation.method(#signInWithEmailAndPassword, [
                  email,
                  password,
                ]),
              ),
            ),
            returnValueForMissingStub: _i4.Future<_i2.UserCredential>.value(
              _FakeUserCredential_0(
                this,
                Invocation.method(#signInWithEmailAndPassword, [
                  email,
                  password,
                ]),
              ),
            ),
          )
          as _i4.Future<_i2.UserCredential>);

  @override
  _i4.Future<void> sendEmailVerification() =>
      (super.noSuchMethod(
            Invocation.method(#sendEmailVerification, []),
            returnValue: _i4.Future<void>.value(),
            returnValueForMissingStub: _i4.Future<void>.value(),
          )
          as _i4.Future<void>);

  @override
  _i4.Future<void> sendPasswordResetEmail(String? email) =>
      (super.noSuchMethod(
            Invocation.method(#sendPasswordResetEmail, [email]),
            returnValue: _i4.Future<void>.value(),
            returnValueForMissingStub: _i4.Future<void>.value(),
          )
          as _i4.Future<void>);

  @override
  _i4.Future<void> changeEmailPassword({
    required String? email,
    required String? oldPassword,
    required String? newPassword,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#changeEmailPassword, [], {
              #email: email,
              #oldPassword: oldPassword,
              #newPassword: newPassword,
            }),
            returnValue: _i4.Future<void>.value(),
            returnValueForMissingStub: _i4.Future<void>.value(),
          )
          as _i4.Future<void>);

  @override
  _i4.Future<_i2.UserCredential> signInWithLink(
    _i2.AuthCredential? authCredential,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#signInWithLink, [authCredential]),
            returnValue: _i4.Future<_i2.UserCredential>.value(
              _FakeUserCredential_0(
                this,
                Invocation.method(#signInWithLink, [authCredential]),
              ),
            ),
            returnValueForMissingStub: _i4.Future<_i2.UserCredential>.value(
              _FakeUserCredential_0(
                this,
                Invocation.method(#signInWithLink, [authCredential]),
              ),
            ),
          )
          as _i4.Future<_i2.UserCredential>);

  @override
  _i4.Future<String?> getIdToken({bool? forceRefresh = false}) =>
      (super.noSuchMethod(
            Invocation.method(#getIdToken, [], {#forceRefresh: forceRefresh}),
            returnValue: _i4.Future<String?>.value(),
            returnValueForMissingStub: _i4.Future<String?>.value(),
          )
          as _i4.Future<String?>);

  @override
  _i4.Future<_i2.IdTokenResult?> getIdTokenResult({
    bool? forceRefresh = false,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#getIdTokenResult, [], {
              #forceRefresh: forceRefresh,
            }),
            returnValue: _i4.Future<_i2.IdTokenResult?>.value(),
            returnValueForMissingStub: _i4.Future<_i2.IdTokenResult?>.value(),
          )
          as _i4.Future<_i2.IdTokenResult?>);

  @override
  _i4.Future<Map<String, dynamic>?> getClaim({bool? forceRefresh = false}) =>
      (super.noSuchMethod(
            Invocation.method(#getClaim, [], {#forceRefresh: forceRefresh}),
            returnValue: _i4.Future<Map<String, dynamic>?>.value(),
            returnValueForMissingStub:
                _i4.Future<Map<String, dynamic>?>.value(),
          )
          as _i4.Future<Map<String, dynamic>?>);

  @override
  _i4.Future<void> userDelete(_i2.User? user) =>
      (super.noSuchMethod(
            Invocation.method(#userDelete, [user]),
            returnValue: _i4.Future<void>.value(),
            returnValueForMissingStub: _i4.Future<void>.value(),
          )
          as _i4.Future<void>);

  @override
  _i4.Future<void> signOut() =>
      (super.noSuchMethod(
            Invocation.method(#signOut, []),
            returnValue: _i4.Future<void>.value(),
            returnValueForMissingStub: _i4.Future<void>.value(),
          )
          as _i4.Future<void>);
}

/// A class which mocks [UserCredential].
///
/// See the documentation for Mockito's code generation for more information.
class MockUserCredential extends _i1.Mock implements _i2.UserCredential {}
