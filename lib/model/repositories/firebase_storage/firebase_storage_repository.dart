// import 'dart:async';
// import 'dart:io';
// import 'dart:typed_data';
//
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:rxdart/rxdart.dart';
//
// final firebaseStorageRepositoryProvider =
//     Provider<FirebaseStorageRepository>((ref) {
//   return FirebaseStorageRepository(FirebaseStorage.instance);
// });
//
//
// class FirebaseStorageRepository {
//   FirebaseStorageRepository(this._storage);
//
//   final FirebaseStorage _storage;
//
//   PublishSubject<TaskSnapshot>? _uploader;
//
//   Stream<TaskSnapshot> get snapshotEvents => _uploader!.stream;
//
//   Future<String> save(
//     Uint8List data, {
//     required String path,
//     String? cacheControl,
//     String mimeType = mimeTypeApplicationOctetStream,
//     Map<String, String> metadata = const <String, String>{},
//   }) async {
//     print(path);
//     final ref = _storage.ref().child(path);
//     final uploadTask = ref.putData(
//       data,
//       SettableMetadata(
//         cacheControl: cacheControl,
//         contentType: mimeType,
//         customMetadata: metadata,
//       ),
//     );
//     if (_uploader != null) {
//       uploadTask.snapshotEvents.listen(_uploader!.add);
//     }
//     final snapshot = await uploadTask.whenComplete(() => null);
//     final downloadUrl = await snapshot.ref.getDownloadURL();
//     return downloadUrl;
//   }
//
//   Future<FullMetadata> saveWithFile(
//     File data, {
//     required String path,
//     String? cacheControl,
//     String mimeType = mimeTypeApplicationOctetStream,
//     Map<String, String> metadata = const <String, String>{},
//     PublishSubject<TaskSnapshot>? uploader,
//   }) async {
//     print(path);
//     final ref = _storage.ref().child(path);
//     final uploadTask = ref.putFile(
//       data,
//       SettableMetadata(
//         cacheControl: cacheControl,
//         contentType: mimeType,
//         customMetadata: metadata,
//       ),
//     );
//     if (uploader != null) {
//       uploadTask.snapshotEvents.listen(uploader.add);
//     }
//     final snapshot = await uploadTask.whenComplete(() => null);
//     return snapshot.ref.getMetadata();
//   }
//
//   Future<FullMetadata> saveWithString(
//     String data, {
//     required String path,
//     PublishSubject<TaskSnapshot>? uploader,
//   }) async {
//     print(path);
//     final ref = _storage.ref().child(path);
//     final uploadTask = ref.putString(data);
//     if (uploader != null) {
//       uploadTask.snapshotEvents.listen(uploader.add);
//     }
//     final snapshot = await uploadTask.whenComplete(() => null);
//     return snapshot.ref.getMetadata();
//   }
//
//   Future<String> fetchDownloadUrl(String dirPath, String filename) =>
//       _storage.ref().child('$dirPath/$filename').getDownloadURL();
//
//   Future<Uint8List?> fetchData(String path) =>
//       _storage.ref().child(path).getData();
//
//   Future<void> delete(String path) => _storage.ref().child(path).delete();
//
//   void fetch() {
//     _uploader ??= PublishSubject<TaskSnapshot>();
//   }
//
//   void dispose() {
//     _uploader?.close();
//     _uploader = null;
//   }
// }
