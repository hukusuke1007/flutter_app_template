import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../model/repositories/firebase_auth/login_type.dart';
import '../../../model/use_cases/auth/fetch_logged_in_type.dart';
import '../../../model/use_cases/auth/sign_in_with_anonymously.dart';
import '../../../utils/provider.dart';

final startUpControllerProvider = FutureProvider.autoDispose<bool>((ref) async {
  final loginType = ref.read(fetchLoggedInTypeProvider)();
  if (loginType != null) {
    ref.read(authStateProvider.notifier).update(
          (state) => loginType == LoginType.anonymously
              ? AuthState.signInWithAnonymously
              : AuthState.signIn,
        );
  } else {
    await ref.read(signInWithAnonymouslyProvider)();
  }
  return true;
});
