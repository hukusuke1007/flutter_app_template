import 'dart:async';

import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'auth_provider_id.dart';
import 'login_type.dart';

part 'firebase_auth_repository.g.dart';

@Riverpod(keepAlive: true)
FirebaseAuthRepository firebaseAuthRepository(Ref ref) {
  return FirebaseAuthRepository(FirebaseAuth.instance);
}

class FirebaseAuthRepository {
  FirebaseAuthRepository(this._auth);

  final FirebaseAuth _auth;

  Stream<User?> get onAuthStateChanged => _auth.authStateChanges();

  Stream<User?> get onUserChanged => _auth.userChanges();

  User? get authUser => _auth.currentUser;

  String? get loggedInUserId => _auth.currentUser?.uid;

  bool get isAnonymously => _auth.currentUser?.isAnonymous ?? false;

  bool get isEmailVerified => _auth.currentUser?.emailVerified ?? false;

  Future<String?> get idToken async {
    return _auth.currentUser?.getIdToken(true);
  }

  LoginType? get loginType {
    final user = _auth.currentUser;
    return user != null ? _loginType(user) : null;
  }

  Future<UserCredential> signInWithAnonymously() => _auth.signInAnonymously();

  Future<UserCredential> signInWithAuthCredential(
    AuthCredential authCredential,
  ) => _auth.signInWithCredential(authCredential);

  Future<UserCredential> createUserWithEmailAndPassword(
    String email,
    String password,
  ) => _auth.createUserWithEmailAndPassword(email: email, password: password);

  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) => _auth.signInWithEmailAndPassword(email: email, password: password);

  Future<void> sendEmailVerification() async {
    await _auth.currentUser?.sendEmailVerification();
  }

  Future<void> sendPasswordResetEmail(String email) =>
      _auth.sendPasswordResetEmail(email: email);

  Future<void> changeEmailPassword({
    required String email,
    required String oldPassword,
    required String newPassword,
  }) async {
    final credential = EmailAuthProvider.credential(
      email: email,
      password: oldPassword,
    );
    await _auth.currentUser?.reauthenticateWithCredential(credential);
    await _auth.currentUser?.updatePassword(newPassword);
  }

  Future<UserCredential> signInWithLink(AuthCredential authCredential) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('user is null');
    }
    final credential = await user.linkWithCredential(authCredential);
    return credential;
  }

  Future<String?> getIdToken({bool forceRefresh = false}) async {
    return _auth.currentUser?.getIdToken(forceRefresh);
  }

  Future<IdTokenResult?> getIdTokenResult({bool forceRefresh = false}) async {
    return _auth.currentUser?.getIdTokenResult(forceRefresh);
  }

  Future<Map<String, dynamic>?> getClaim({bool forceRefresh = false}) async {
    final result = await _auth.currentUser?.getIdTokenResult(forceRefresh);
    return result?.claims;
  }

  Future<void> userDelete(User user) => user.delete();

  Future<void> signOut() => _auth.signOut();

  LoginType? _loginType(User user) {
    if (user.isAnonymous) {
      return LoginType.anonymously;
    }
    if (user.providerData.firstWhereOrNull(
          (element) => element.providerId == AuthProviderId.email.value,
        ) !=
        null) {
      return LoginType.email;
    }
    if (user.providerData.firstWhereOrNull(
          (element) => element.providerId == AuthProviderId.apple.value,
        ) !=
        null) {
      return LoginType.apple;
    }
    if (user.providerData.firstWhereOrNull(
          (element) => element.providerId == AuthProviderId.google.value,
        ) !=
        null) {
      return LoginType.google;
    }
    return null;
  }
}
