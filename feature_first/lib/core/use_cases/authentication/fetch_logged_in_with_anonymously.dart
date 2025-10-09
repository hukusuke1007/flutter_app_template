import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../repositories/firebase_auth/firebase_auth_repository.dart';
import '../../repositories/firebase_auth/login_type.dart';

part 'fetch_logged_in_with_anonymously.g.dart';

@Riverpod(keepAlive: true)
FetchLoggedInWithAnonymously fetchLoggedInWithAnonymously(Ref ref) {
  return FetchLoggedInWithAnonymously(ref);
}

class FetchLoggedInWithAnonymously {
  FetchLoggedInWithAnonymously(this._ref);
  final Ref _ref;

  bool call() {
    final loginType = _ref.read(firebaseAuthRepositoryProvider).loginType;
    return loginType != null && loginType == LoginType.anonymously;
  }
}
