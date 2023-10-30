import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/converters/date_time_timestamp_converter.dart';
import '../../../core/repositories/firestore/document.dart';

part 'counter.freezed.dart';
part 'counter.g.dart';

@freezed
class Counter with _$Counter {
  const factory Counter({
    int? count,
    @DateTimeTimestampConverter() DateTime? createdAt,
    @DateTimeTimestampConverter() DateTime? updatedAt,
  }) = _Counter;
  const Counter._();

  factory Counter.fromJson(Map<String, dynamic> json) =>
      _$CounterFromJson(json);

  static String get collectionPath => 'sample/v1/counters';
  static CollectionReference<SnapType> colRef() =>
      Document.colRef(collectionPath);

  static String docPath(String id) => '$collectionPath/$id';
  static DocumentReference<SnapType> docRef(String id) =>
      Document.docRefWithDocPath(docPath(id));

  Map<String, dynamic> get toDoc => <String, dynamic>{
        ...toJson(),
        'createdAt': createdAt ?? FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      };
}
