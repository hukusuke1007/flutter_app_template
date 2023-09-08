import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../repositories/firebase_auth/firebase_auth_repository.dart';
import 'auth_state_controller.dart';

part 'fetch_my_user_id.g.dart';

@riverpod
String? fetchMyUserId(FetchMyUserIdRef ref) {
  ref.watch(authStateControllerProvider);
  return ref.watch(firebaseAuthRepositoryProvider).loggedInUserId;
}
