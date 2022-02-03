import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../model/repositories/firestore/document.dart';
import '../../converters/date_time_timestamp_converter.dart';

part 'counter.freezed.dart';
part 'counter.g.dart';

@freezed
class Counter with _$Counter {
  factory Counter({
    String? counterId,
    int? count,
    @DateTimeTimestampConverter() DateTime? createdAt,
    @DateTimeTimestampConverter() DateTime? updatedAt,
  }) = _Counter;
  Counter._();

  factory Counter.fromJson(Map<String, dynamic> json) =>
      _$CounterFromJson(json);

  static String get collectionPath => 'sample/v1/counters';
  static CollectionReference<SnapType> colRef() =>
      Document.colRef(collectionPath);

  static String docPath(String id) => '$collectionPath/$id';
  static DocumentReference<SnapType> docRef(String id) =>
      Document.docRef(docPath(id));
}
