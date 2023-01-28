import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../model/repositories/firebase_auth/firebase_auth_repository.dart';
import '../../../repositories/firebase_auth/login_type.dart';

final fetchLoggedInTypeProvider =
    Provider<FetchLoggedInType>(FetchLoggedInType.new);

class FetchLoggedInType {
  FetchLoggedInType(this._ref);
  final Ref _ref;

  LoginType? call() {
    final loginType = _ref.read(firebaseAuthRepositoryProvider).loginType;
    return loginType;
  }
}
