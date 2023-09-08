import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../repositories/firebase_auth/firebase_auth_repository.dart';
import 'auth_state_controller.dart';

final fetchMyUserIdProvider = Provider.autoDispose<String?>((ref) {
  ref.watch(authStateControllerProvider);
  return ref.watch(firebaseAuthRepositoryProvider).loggedInUserId;
});
