import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../utils/provider.dart';
import '../../../repositories/firebase_auth/firebase_auth_repository.dart';

final fetchMyUserIdProvider = Provider.autoDispose<String?>((ref) {
  ref.watch(authStateProvider);
  return ref.watch(firebaseAuthRepositoryProvider).loggedInUserId;
});
