import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/repositories/firebase_auth/firebase_auth_repository.dart';
import '../../../core/use_cases/authentication/auth_state_controller.dart';

part 'fetch_my_user_id.g.dart';

@riverpod
String? fetchMyUserId(Ref ref) {
  ref.watch(authStateControllerProvider);
  return ref.watch(firebaseAuthRepositoryProvider).loggedInUserId;
}
