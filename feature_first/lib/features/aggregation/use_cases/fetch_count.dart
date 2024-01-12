import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fetch_count.g.dart';

@riverpod
class FetchCount extends _$FetchCount {
  @override
  Future<int> build() async {
    final snap = await FirebaseFirestore.instance
        .collection('aggregation')
        .count()
        .get();

    return snap.count ?? 0;
  }
}
