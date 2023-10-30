import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../converters/date_time_timestamp_converter.dart';
import '../../extensions/date_extension.dart';
import '../../repositories/firestore/document.dart';

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

  /// ドキュメントパス
  static String get collectionName => 'posts';
  static String docPath(String docId) => '$collectionName/$docId';
  static DocumentReference<SnapType> docRef(String docId) =>
      Document.docRefWithDocPath(docPath(docId));

  /// 日付
  String get dateLabel {
    final date = createdAt;
    if (date == null) {
      return '-';
    }
    return date.timelineLabel;
  }

  /// サーバーへ保存するMap（作成）
  Map<String, dynamic> toCreateDoc() => <String, dynamic>{
        ...toJson(),
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      };

  /// サーバーへ保存するMap（更新）
  Map<String, dynamic> toUpdateDoc() => <String, dynamic>{
        'text': text,
        'updatedAt': FieldValue.serverTimestamp(),
      };
}
