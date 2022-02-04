import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

typedef SnapType = Map<String, dynamic>;

@immutable
class Document<T extends Object> {
  const Document({
    required this.ref,
    required this.exists,
    required this.entity,
  });

  final DocumentReference<SnapType> ref;
  final bool exists;
  final T? entity;

  String get id => ref.id;
  String get collectionName => ref.parent.id;
  String get path => ref.path;

  /// CollectionReference
  static CollectionReference<SnapType> colRef(String path) =>
      FirebaseFirestore.instance.collection(path);

  static Query<SnapType> colGroupQuery(String path) =>
      FirebaseFirestore.instance.collectionGroup(path);

  /// DocumentReference
  static DocumentReference<SnapType> docRef(String collectionPath) =>
      FirebaseFirestore.instance.collection(collectionPath).doc();

  static DocumentReference<SnapType> docRefWithDocPath(String docPath) =>
      FirebaseFirestore.instance.doc(docPath);

  static String docId(String collectionPath) =>
      FirebaseFirestore.instance.collection(collectionPath).doc().id;

  /// Entity copy
  Document<T> copyWith(T newEntity) => Document(
        ref: ref,
        exists: exists,
        entity: newEntity,
      );
}
