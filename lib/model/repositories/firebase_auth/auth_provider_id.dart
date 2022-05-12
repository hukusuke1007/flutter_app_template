/// FirebaseAuthプロバイダーID
enum AuthProviderId {
  apple('apple.com'),
  google('google.com'),
  email('password');

  const AuthProviderId(this.value);
  final String value;
}
