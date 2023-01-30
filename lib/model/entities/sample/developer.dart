import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../extensions/date_extension.dart';
import '../../../model/entities/sample/timeline/post.dart';
import '../../../model/repositories/firestore/document.dart';
import '../../converters/date_time_timestamp_converter.dart';
import '../storage_file/storage_file.dart';

part 'developer.freezed.dart';
part 'developer.g.dart';

@freezed
class Developer with _$Developer {
  const factory Developer({
    String? developerId,
    String? name,
    StorageFile? image,
    @DateTimeTimestampConverter() DateTime? birthdate,
    @DateTimeTimestampConverter() DateTime? createdAt,
    @DateTimeTimestampConverter() DateTime? updatedAt,
  }) = _Developer;
  const Developer._();

  factory Developer.fromJson(Map<String, dynamic> json) =>
      _$DeveloperFromJson(json);

  /// ドキュメントパス
  static String get collectionPath => 'sample/v1/developers';
  static CollectionReference<SnapType> colRef() =>
      Document.colRef(collectionPath);
  static String docPath(String id) => '$collectionPath/$id';
  static DocumentReference<SnapType> docRef(String id) =>
      Document.docRefWithDocPath(docPath(id));

  /// 投稿のドキュメントパス
  static String postDocPath({
    required String userId,
    required String docId,
  }) =>
      '$collectionPath/$userId/${Post.collectionName}/$docId';

  /// 画像パス
  static String imagePath(
    String id,
    String filename,
  ) =>
      '${docPath(id)}/image/$filename';

  /// 誕生日のラベル
  String get birthdateLabel {
    return birthdate?.format(pattern: 'yyyy/M/d') ?? '-';
  }

  /// サーバーへ保存するMap
  Map<String, dynamic> get toDocWithNotImage {
    final data = <String, dynamic>{
      ...toJson(),
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    }..remove('image');
    return data;
  }

  /// 画像情報をサーバーへ保存するMap
  Map<String, dynamic> get toImageOnly => <String, dynamic>{
        'developerId': developerId,
        'image': image?.toJson(),
        'createdAt': createdAt ?? FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      };
}
