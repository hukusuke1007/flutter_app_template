import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'document.dart';

final collectionRepositoryProvider = Provider<CollectionRepository>(
  (ref) => CollectionRepository(FirebaseFirestore.instance),
);

class CollectionRepository {
  CollectionRepository(this._firestore);

  final FirebaseFirestore _firestore;

  CollectionReference<SnapType> collectionRef(String collectionPath) =>
      _firestore.collection(collectionPath);

  Stream<QuerySnapshot<SnapType>?> snapshots(Query<SnapType> query) =>
      query.snapshots();
}
