import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'document.dart';

part 'document_repository.g.dart';

@Riverpod(keepAlive: true)
DocumentRepository documentRepository(Ref ref) {
  return DocumentRepository(FirebaseFirestore.instance);
}

class DocumentRepository {
  DocumentRepository(this._firestore);

  final FirebaseFirestore _firestore;

  WriteBatch get batch => _firestore.batch();

  Future<void> save(
    String documentPath, {
    required Map<String, dynamic> data,
  }) async {
    final doc = _firestore.doc(documentPath);
    await doc.set(data, SetOptions(merge: true));
  }

  Future<void> update(
    String documentPath, {
    required Map<String, dynamic> data,
  }) async {
    final doc = _firestore.doc(documentPath);
    await doc.update(data);
  }

  Future<Document<T>> fetch<T extends Object>(
    String documentPath, {
    Source source = Source.serverAndCache,
    void Function(Document<T>?)? fromCache,
    required T Function(Map<String, dynamic>) decode,
  }) async {
    if (fromCache != null) {
      try {
        final cache = await _firestore
            .doc(documentPath)
            .get(const GetOptions(source: Source.cache));
        fromCache(
          Document(
            ref: cache.reference,
            exists: cache.exists,
            entity: cache.exists ? decode(cache.data()!) : null,
          ),
        );
      } on Exception catch (_) {
        // ignore exception
        fromCache(null);
      }
    }

    final snap = await _firestore
        .doc(documentPath)
        .get(GetOptions(source: source));
    return Document(
      ref: snap.reference,
      exists: snap.exists,
      entity: snap.exists ? decode(snap.data()!) : null,
    );
  }

  Future<Document<T>> fetchCache<T extends Object>(
    String documentPath, {
    required T Function(Map<String, dynamic>) decode,
  }) async {
    final doc = _firestore.doc(documentPath);
    try {
      final cache = await doc.get(const GetOptions(source: Source.cache));
      if (cache.exists) {
        return Document(
          ref: cache.reference,
          exists: cache.exists,
          entity: cache.exists ? decode(cache.data()!) : null,
        );
      }
    } on Exception catch (_) {
      // ignore exception
    }
    final snap = await doc.get(
      // ignore: avoid_redundant_argument_values
      const GetOptions(source: Source.serverAndCache),
    );
    return Document(
      ref: snap.reference,
      exists: snap.exists,
      entity: snap.exists ? decode(snap.data()!) : null,
    );
  }

  Future<Document<T>> fetchCacheOnly<T extends Object>(
    String documentPath, {
    required T? Function(Map<String, dynamic>) decode,
  }) async {
    final doc = _firestore.doc(documentPath);
    try {
      final cache = await doc.get(const GetOptions(source: Source.cache));
      if (cache.exists) {
        return Document(
          ref: cache.reference,
          exists: cache.exists,
          entity: cache.exists ? decode(cache.data()!) : null,
        );
      }
    } on Exception catch (_) {
      // ignore exception
    }
    return Document(ref: doc, entity: null, exists: false);
  }

  Future<bool> exists(String documentPath) async {
    final doc = _firestore.doc(documentPath);
    // ignore: avoid_redundant_argument_values
    final snap = await doc.get(const GetOptions(source: Source.serverAndCache));
    return snap.exists;
  }

  Future<bool> existsCache(String documentPath) async {
    final doc = _firestore.doc(documentPath);
    try {
      final cache = await doc.get(const GetOptions(source: Source.cache));
      return cache.exists;
    } on Exception catch (_) {
      // ignore exception
    }
    // ignore: avoid_redundant_argument_values
    final snap = await doc.get(const GetOptions(source: Source.serverAndCache));
    return snap.exists;
  }

  Stream<DocumentSnapshot<SnapType>> snapshots(String documentPath) =>
      _firestore.doc(documentPath).snapshots();

  Future<void> remove(String documentPath) =>
      _firestore.doc(documentPath).delete();

  Future<T> transaction<T>(TransactionHandler<T> transactionHandler) =>
      _firestore.runTransaction<T>(transactionHandler);
}
