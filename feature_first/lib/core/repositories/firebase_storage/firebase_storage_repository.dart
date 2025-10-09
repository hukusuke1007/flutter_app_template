import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';

import 'mime_type.dart';

part 'firebase_storage_repository.g.dart';

@Riverpod(keepAlive: true)
FirebaseStorageRepository firebaseStorageRepository(Ref ref) {
  return FirebaseStorageRepository(FirebaseStorage.instance);
}

class FirebaseStorageRepository {
  FirebaseStorageRepository(this._storage);

  final FirebaseStorage _storage;

  PublishSubject<TaskSnapshot>? _uploader;

  Stream<TaskSnapshot> get snapshotEvents => _uploader!.stream;

  Future<String> save(
    Uint8List data, {
    required String path,
    String? cacheControl,
    MimeType? mimeType,
    Map<String, String> metadata = const <String, String>{},
  }) async {
    final ref = _storage.ref(path);
    final uploadTask = ref.putData(
      data,
      SettableMetadata(
        cacheControl: cacheControl,
        contentType: mimeType?.value,
        customMetadata: metadata,
      ),
    );
    if (_uploader != null) {
      uploadTask.snapshotEvents.listen(_uploader!.add);
    }
    final snapshot = await uploadTask.whenComplete(() => null);
    final downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<FullMetadata> saveWithFile(
    File data, {
    required String path,
    String? cacheControl,
    MimeType? mimeType,
    Map<String, String> metadata = const <String, String>{},
    PublishSubject<TaskSnapshot>? uploader,
  }) async {
    final ref = _storage.ref(path);
    final uploadTask = ref.putFile(
      data,
      SettableMetadata(
        cacheControl: cacheControl,
        contentType: mimeType?.value,
        customMetadata: metadata,
      ),
    );
    if (uploader != null) {
      uploadTask.snapshotEvents.listen(uploader.add);
    }
    final snapshot = await uploadTask.whenComplete(() => null);
    return snapshot.ref.getMetadata();
  }

  Future<FullMetadata> saveWithString(
    String data, {
    required String path,
    PublishSubject<TaskSnapshot>? uploader,
  }) async {
    final ref = _storage.ref(path);
    final uploadTask = ref.putString(data);
    if (uploader != null) {
      uploadTask.snapshotEvents.listen(uploader.add);
    }
    final snapshot = await uploadTask.whenComplete(() => null);
    return snapshot.ref.getMetadata();
  }

  Future<String> fetchDownloadUrl(String path) =>
      _storage.ref(path).getDownloadURL();

  Future<Uint8List?> fetchData(String path) => _storage.ref(path).getData();

  Future<void> delete(String path) => _storage.ref().child(path).delete();

  void fetch() {
    _uploader ??= PublishSubject<TaskSnapshot>();
  }

  void dispose() {
    _uploader?.close();
    _uploader = null;
  }
}
