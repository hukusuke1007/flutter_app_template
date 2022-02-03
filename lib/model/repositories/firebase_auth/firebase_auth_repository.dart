import 'dart:async';

import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'login_type.dart';

final firebaseAuthRepositoryProvider = Provider<FirebaseAuthRepository>((_) {
  return FirebaseAuthRepository(FirebaseAuth.instance);
});

class ProviderCredential {
  ProviderCredential(this.credential, this.userId);
  final OAuthCredential credential;
  final String userId;
}

class FirebaseAuthRepository {
  FirebaseAuthRepository(this._auth);

  final FirebaseAuth _auth;

  Stream<User?> get onAuthStateChanged => _auth.authStateChanges();

  User? get authUser => _auth.currentUser;

  String? get loggedInUserId => _auth.currentUser?.uid;

  bool get isAnonymously => _auth.currentUser?.isAnonymous ?? false;

  bool get isEmailVerification => _auth.currentUser?.emailVerified ?? false;

  Future<String?> get idToken async {
    return _auth.currentUser != null
        ? _auth.currentUser!.getIdToken(true)
        : null;
  }

  LoginType? get loginType {
    final user = _auth.currentUser;
    return user != null ? _loginType(user) : null;
  }

  Future<UserCredential> signInWithAnonymously() => _auth.signInAnonymously();

  Future<UserCredential> signInWithAuthCredential(
          AuthCredential authCredential) =>
      _auth.signInWithCredential(authCredential);

  Future<UserCredential> signInWithLink(AuthCredential authCredential) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('user is null');
    }
    return user.linkWithCredential(authCredential);
  }

  Future<void> userDelete(User user) => user.delete();

  Future<void> signOut() => _auth.signOut();

  LoginType? _loginType(User user) {
    if (user.isAnonymous) {
      return LoginType.anonymously;
    }
    if (user.providerData
            .firstWhereOrNull((element) => element.providerId == 'apple.com') !=
        null) {
      return LoginType.apple;
    }

    if (user.providerData.firstWhereOrNull(
            (element) => element.providerId == 'google.com') !=
        null) {
      return LoginType.google;
    }
    return null;
  }
}
