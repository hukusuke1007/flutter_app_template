import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'document.dart';

final collectionRepositoryProvider = Provider<CollectionRepository>(
  (_) => CollectionRepository(FirebaseFirestore.instance),
);

class CollectionRepository {
  CollectionRepository(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<SnapType> ref(String collectionPath) =>
      _firestore.collection(collectionPath);

  Query<SnapType> group(String collectionName) =>
      _firestore.collectionGroup(collectionName);
}
