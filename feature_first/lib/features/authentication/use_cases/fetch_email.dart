import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/repositories/firebase_auth/firebase_auth_repository.dart';

final fetchEmailProvider = Provider.autoDispose<String?>((ref) {
  return ref.watch(firebaseAuthRepositoryProvider).authUser?.email;
});
