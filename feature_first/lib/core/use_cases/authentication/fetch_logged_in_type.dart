import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../repositories/firebase_auth/firebase_auth_repository.dart';
import '../../repositories/firebase_auth/login_type.dart';

part 'fetch_logged_in_type.g.dart';

@Riverpod(keepAlive: true)
FetchLoggedInType fetchLoggedInType(Ref ref) {
  return FetchLoggedInType(ref);
}

class FetchLoggedInType {
  FetchLoggedInType(this._ref);
  final Ref _ref;

  LoginType? call() {
    final loginType = _ref.read(firebaseAuthRepositoryProvider).loginType;
    return loginType;
  }
}
