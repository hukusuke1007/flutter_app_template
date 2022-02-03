import 'package:flutter_app_template/model/repositories/firebase_auth/firebase_auth_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../repositories/firebase_auth/firebase_auth_repository.dart';
import '../../repositories/firebase_auth/login_type.dart';

final fetchLoggedInWithAnonymously = Provider<FetchLoggedInWithAnonymously>(
  (ref) => FetchLoggedInWithAnonymously(ref.read),
);

class FetchLoggedInWithAnonymously {
  FetchLoggedInWithAnonymously(this._read);
  final Reader _read;

  bool call() {
    final loginType = _read(firebaseAuthRepositoryProvider).loginType;
    return loginType != null && loginType == LoginType.anonymously;
  }
}
