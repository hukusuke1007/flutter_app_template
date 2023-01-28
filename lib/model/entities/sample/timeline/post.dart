import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../model/repositories/firestore/document.dart';
import '../../../converters/date_time_timestamp_converter.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
class Post with _$Post {
  const factory Post({
    required String postId,
    required String userId,
    required String text,
    @Default(0) int likeCount,
    @DateTimeTimestampConverter() DateTime? createdAt,
    @DateTimeTimestampConverter() DateTime? updatedAt,
  }) = _Post;
  const Post._();

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  static String get collectionPath => 'sample/v1/posts';
  static CollectionReference<SnapType> colRef() =>
      Document.colRef(collectionPath);

  static String docPath(String id) => '$collectionPath/$id';
  static DocumentReference<SnapType> docRef(String id) =>
      Document.docRefWithDocPath(docPath(id));
}
