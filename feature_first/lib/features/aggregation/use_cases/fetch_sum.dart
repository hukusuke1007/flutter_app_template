import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fetch_sum.g.dart';

@riverpod
class FetchSum extends _$FetchSum {
  @override
  Future<double> build() async {
    final snap = await FirebaseFirestore.instance
        .collection('aggregation')
        .aggregate(sum('value'))
        .get();

    return snap.getSum('value') ?? 0;
  }
}
