import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../exceptions/app_exception.dart';
import '../../../entities/sample/developer.dart';
import '../../../repositories/firebase_auth/firebase_auth_repository.dart';
import '../../../repositories/firestore/document_repository.dart';
import 'fetch_my_profile.dart';

final saveMyProfileProvider = Provider(SaveMyProfile.new);

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
