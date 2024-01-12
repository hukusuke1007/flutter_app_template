import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fetch_aggregation_query_snapshot.g.dart';

@riverpod
class FetchAggregateQuerySnapshot extends _$FetchAggregateQuerySnapshot {
  @override
  Future<AggregateQuerySnapshot> build() async {
    final snap = await FirebaseFirestore.instance
        .collection('aggregation')
        .count()
        .get();
    return snap;
  }
}
