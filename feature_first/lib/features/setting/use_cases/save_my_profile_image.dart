import 'dart:typed_data';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/entities/developer/developer.dart';
import '../../../../core/exceptions/app_exception.dart';
import '../../../../core/utils/uuid_generator.dart';
import '../../../core/entities/storage_file/storage_file.dart';
import '../../../core/repositories/firebase_auth/firebase_auth_repository.dart';
import '../../../core/repositories/firebase_storage/firebase_storage_repository.dart';
import '../../../core/repositories/firebase_storage/mime_type.dart';
import '../../../core/repositories/firestore/document_repository.dart';
import 'fetch_my_profile.dart';

part 'save_my_profile_image.g.dart';

@Riverpod(keepAlive: true)
SaveMyProfileImage saveMyProfileImage(Ref ref) {
  return SaveMyProfileImage(ref);
}

class SaveMyProfileImage {
  SaveMyProfileImage(this._ref);
  final Ref _ref;

  Future<void> call(Uint8List file) async {
    final userId = _ref.read(firebaseAuthRepositoryProvider).loggedInUserId;
    if (userId == null) {
      throw AppException(title: 'ログインしてください');
    }

    /// 画像をCloudStorageへ保存
    final filename = UuidGenerator.create();
    final imagePath = Developer.imagePath(userId, filename);
    const mimeType = MimeType.applicationOctetStream;
    final imageUrl = await _ref
        .read(firebaseStorageRepositoryProvider)
        .save(file, path: imagePath, mimeType: mimeType);

    /// 画像情報をFirestoreへ保存
    final profile = _ref.read(fetchMyProfileProvider).value;
    final newProfile = (profile ?? Developer(developerId: userId)).copyWith(
      image: StorageFile(
        url: imageUrl,
        path: imagePath,
        mimeType: mimeType.value,
      ),
    );
    await _ref
        .read(documentRepositoryProvider)
        .save(Developer.docPath(userId), data: newProfile.toImageOnly);

    /// 古い画像をCloudStorageから削除
    final oldImage = profile?.image;
    if (oldImage != null) {
      await _ref.read(firebaseStorageRepositoryProvider).delete(oldImage.path);
    }
  }
}
