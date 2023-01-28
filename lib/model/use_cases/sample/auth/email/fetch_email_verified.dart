import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../repositories/firebase_auth/firebase_auth_repository.dart';

final fetchEmailVerifiedProvider =
    FutureProvider.autoDispose<bool>((ref) async {
  await ref.read(firebaseAuthRepositoryProvider).authUser?.reload();
  return ref.read(firebaseAuthRepositoryProvider).isEmailVerified;
});
