import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/repositories/firebase_auth/firebase_auth_repository.dart';

final fetchEmailVerifiedProvider = FutureProvider.autoDispose<bool>((
  ref,
) async {
  await ref.watch(firebaseAuthRepositoryProvider).authUser?.reload();
  return ref.watch(firebaseAuthRepositoryProvider).isEmailVerified;
});
