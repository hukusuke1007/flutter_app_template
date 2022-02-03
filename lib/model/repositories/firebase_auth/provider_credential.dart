import 'package:firebase_auth/firebase_auth.dart';

class ProviderCredential {
  ProviderCredential(this.credential, this.userId);
  final OAuthCredential credential;
  final String userId;
}
