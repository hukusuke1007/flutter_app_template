// import 'dart:async';
// import 'dart:convert';
//
// import 'package:collection/collection.dart';
// import 'package:crypto/crypto.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:nonce/nonce.dart';
// import 'package:sekaiisanwalking/utils/logger.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';
//
// import 'login_type.dart';
//
// final firebaseAuthRepositoryProvider = Provider<FirebaseAuthRepository>((_) {
//   return FirebaseAuthRepository(
//     FirebaseAuth.instance,
//     GoogleSignIn(scopes: ['email']),
//   );
// });
//
// class ProviderCredential {
//   ProviderCredential(this.credential, this.userId);
//   final OAuthCredential credential;
//   final String userId;
// }
//
// class FirebaseAuthRepository {
//   FirebaseAuthRepository(this._auth, this._googleSignIn);
//
//   final FirebaseAuth _auth;
//   final GoogleSignIn _googleSignIn;
//
//   Stream<User?> get onAuthStateChanged => _auth.authStateChanges();
//
//   User? get authUser => _auth.currentUser;
//
//   String? get loggedInUserId => _auth.currentUser?.uid;
//
//   bool get isAnonymously => _auth.currentUser?.isAnonymous ?? false;
//
//   bool get isEmailVerification => _auth.currentUser?.emailVerified ?? false;
//
//   Future<String?> get idToken async {
//     return _auth.currentUser != null
//         ? _auth.currentUser!.getIdToken(true)
//         : null;
//   }
//
//   LoginType? get loginType {
//     final user = _auth.currentUser;
//     return user != null ? _loginType(user) : null;
//   }
//
//   Future<ProviderCredential?> get credentialOfGoogle async {
//     final googleUser = await _googleSignIn.signIn();
//     if (googleUser == null) {
//       return null;
//     }
//     final auth = await googleUser.authentication;
//     final result = GoogleAuthProvider.credential(
//       idToken: auth.idToken,
//       accessToken: auth.accessToken,
//     );
//
//     return ProviderCredential(result, googleUser.id);
//   }
//
//   Future<ProviderCredential?> get credentialOfApple async {
//     final rawNonce = Nonce.generate();
//     final state = Nonce.generate();
//     final credential = await SignInWithApple.getAppleIDCredential(
//       scopes: [
//         AppleIDAuthorizationScopes.email,
//         AppleIDAuthorizationScopes.fullName,
//       ],
//       nonce: sha256.convert(utf8.encode(rawNonce)).toString(),
//       state: state,
//     );
//     logger.info(credential.state);
//     if (state != credential.state) {
//       throw AssertionError('state not matched!');
//     }
//     if (credential.userIdentifier == null) {
//       return null;
//     }
//     final result = OAuthProvider('apple.com').credential(
//       idToken: credential.identityToken,
//       accessToken: credential.authorizationCode,
//       rawNonce: rawNonce,
//     );
//     return ProviderCredential(result, credential.userIdentifier!);
//   }
//
//   Future<UserCredential> signInWithAnonymously() => _auth.signInAnonymously();
//
//   Future<UserCredential> signInWithAuthCredential(
//           AuthCredential authCredential) =>
//       _auth.signInWithCredential(authCredential);
//
//   Future<UserCredential> signInWithLink(AuthCredential authCredential) async {
//     final user = _auth.currentUser;
//     if (user == null) {
//       throw Exception('user is null');
//     }
//     return user.linkWithCredential(authCredential);
//   }
//
//   Future<void> userDelete(User user) => user.delete();
//
//   Future<void> signOut() => _auth.signOut();
//
//   LoginType? _loginType(User user) {
//     if (user.isAnonymous) {
//       return LoginType.anonymously;
//     }
//     if (user.providerData
//             .firstWhereOrNull((element) => element.providerId == 'apple.com') !=
//         null) {
//       return LoginType.apple;
//     }
//
//     if (user.providerData.firstWhereOrNull(
//             (element) => element.providerId == 'google.com') !=
//         null) {
//       return LoginType.google;
//     }
//     return null;
//   }
// }
