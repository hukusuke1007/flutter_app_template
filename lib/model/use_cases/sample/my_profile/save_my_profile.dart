import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../exceptions/app_exception.dart';
import '../../../entities/sample/developer.dart';
import '../../../repositories/firebase_auth/firebase_auth_repository.dart';
import '../../../repositories/firestore/document_repository.dart';
import 'fetch_my_profile.dart';

part 'save_my_profile.g.dart';

@Riverpod(keepAlive: true)
SaveMyProfile saveMyProfile(SaveMyProfileRef ref) {
  return SaveMyProfile(ref);
}

class SaveMyProfile {
  SaveMyProfile(this._ref);
  final Ref _ref;

  Future<void> call({
    String? name,
    DateTime? birthdate,
  }) async {
    final userId = _ref.read(firebaseAuthRepositoryProvider).loggedInUserId;
    if (userId == null) {
      throw AppException(title: 'ログインしてください');
    }
    final profile = _ref.read(fetchMyProfileProvider).asData?.value;
    final newProfile = (profile ?? Developer(developerId: userId)).copyWith(
      name: name,
      birthdate: birthdate,
    );
    await _ref.read(documentRepositoryProvider).save(
          Developer.docPath(userId),
          data: newProfile.toDocWithNotImage,
        );
  }
}
