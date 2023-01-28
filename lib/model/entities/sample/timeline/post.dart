import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../model/repositories/firestore/document.dart';
import '../../../converters/date_time_timestamp_converter.dart';
import '../../../repositories/firestore/collection_paging_repository.dart';

part 'post.freezed.dart';
part 'post.g.dart';

final postCollectionPagingProvider = Provider.family
    .autoDispose<CollectionPagingRepository<Post>, CollectionParam<Post>>(
        (ref, query) {
  return CollectionPagingRepository<Post>(
    query: query.query,
    limit: query.limit,
    decode: query.decode,
  );
});

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
