import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../model/repositories/firebase_auth/firebase_auth_repository.dart';
import '../../../repositories/firebase_auth/login_type.dart';

final fetchLoggedInWithAnonymouslyProvider =
    Provider<FetchLoggedInWithAnonymously>(
  FetchLoggedInWithAnonymously.new,
);

class FetchLoggedInWithAnonymously {
  FetchLoggedInWithAnonymously(this._ref);
  final Ref _ref;

  bool call() {
    final loginType = _ref.read(firebaseAuthRepositoryProvider).loginType;
    return loginType != null && loginType == LoginType.anonymously;
  }
}
