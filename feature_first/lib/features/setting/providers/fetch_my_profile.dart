import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/entities/developer/developer.dart';
import '../../../core/providers/authentication/auth_state_controller.dart';
import '../../../core/repositories/firebase_auth/firebase_auth_repository.dart';
import '../../../core/repositories/firestore/document_repository.dart';
import '../../../core/utils/logger.dart';

part 'fetch_my_profile.g.dart';

@riverpod
class FetchMyProfile extends _$FetchMyProfile {
  @override
  Stream<Developer?> build() {
    final authState = ref.watch(authStateControllerProvider);
    if (authState == AuthState.noSignIn) {
      return Stream.value(null);
    }
    final userId = ref.watch(firebaseAuthRepositoryProvider).loggedInUserId;
    if (userId == null) {
      return Stream.value(null);
    }
    logger.info('userId: $userId');
    return ref
        .watch(documentRepositoryProvider)
        .snapshots(Developer.docPath(userId))
        .map((event) {
      final data = event.data();
      return data != null ? Developer.fromJson(data) : null;
    });
  }
}
