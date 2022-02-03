// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
//
// typedef SnapType = Map<String, dynamic>;
//
// @immutable
// class Document<T extends Object> {
//   const Document({
//     required this.ref,
//     required this.exists,
//     required this.entity,
//   });
//
//   final DocumentReference<SnapType> ref;
//   final bool exists;
//   final T? entity;
//
//   String get id => ref.id;
//   String get collectionName => ref.parent.id;
//   String get path => ref.path;
//
//   static CollectionReference<SnapType> collectionRef(String path) =>
//       FirebaseFirestore.instance.collection(path);
//
//   static Query<SnapType> collectionGroupQuery(String path) =>
//       FirebaseFirestore.instance.collectionGroup(path);
//
//   static DocumentReference<SnapType> docRef(String docPath) =>
//       FirebaseFirestore.instance.doc(docPath);
//   static String get docId => FirebaseFirestore.instance.collection('collection').doc().id;
//
//   Document<T> copyWith(T newEntity) => Document(
//         ref: ref,
//         exists: exists,
//         entity: newEntity,
//       );
// }
