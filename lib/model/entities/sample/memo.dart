import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../extensions/date_extension.dart';
import '../../../model/repositories/firestore/document.dart';
import '../../converters/date_time_timestamp_converter.dart';
import '../../repositories/firestore/collection_paging_repository.dart';

part 'memo.freezed.dart';
part 'memo.g.dart';

final memoCollectionPagingProvider = Provider.family
    .autoDispose<CollectionPagingRepository<Memo>, CollectionParam<Memo>>(
        (ref, query) {
  return CollectionPagingRepository<Memo>(
    query: query.query,
    initialLimit: query.initialLimit,
    pagingLimit: query.pagingLimit,
    decode: query.decode,
  );
});

/// Entity
@freezed
class Memo with _$Memo {
  const factory Memo({
    String? memoId,
    String? text,
    @DateTimeTimestampConverter() DateTime? createdAt,
    @DateTimeTimestampConverter() DateTime? updatedAt,
  }) = _Memo;
  const Memo._();

  factory Memo.fromJson(Map<String, dynamic> json) => _$MemoFromJson(json);

  static String collectionPath(String userId) =>
      'sample/v1/developers/$userId/memos';
  static CollectionReference<SnapType> colRef(String userId) =>
      Document.colRef(collectionPath(userId));

  static String docPath(String userId, String id) =>
      '${collectionPath(userId)}/$id';
  static DocumentReference<SnapType> docRef(String userId, String id) =>
      Document.docRefWithDocPath(docPath(userId, id));

  Map<String, dynamic> get toCreateDoc => <String, dynamic>{
        'memoId': memoId,
        'text': text,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      };

  Map<String, dynamic> get toUpdateDoc => <String, dynamic>{
        'text': text,
        'updatedAt': FieldValue.serverTimestamp(),
      };

  String get dateLabel {
    final date = createdAt;
    if (date == null) {
      return '-';
    }
    return date.format(pattern: 'yyyy.M.d HH:mm');
  }
}
