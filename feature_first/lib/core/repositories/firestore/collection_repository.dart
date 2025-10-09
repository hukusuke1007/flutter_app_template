import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'document.dart';

part 'collection_repository.g.dart';

@Riverpod(keepAlive: true)
CollectionRepository collectionRepository(Ref ref) {
  return CollectionRepository(FirebaseFirestore.instance);
}

class CollectionRepository {
  CollectionRepository(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<SnapType> ref(String collectionPath) =>
      _firestore.collection(collectionPath);

  Query<SnapType> group(String collectionName) =>
      _firestore.collectionGroup(collectionName);
}
