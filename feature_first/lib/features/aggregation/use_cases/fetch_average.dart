import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fetch_average.g.dart';

@riverpod
class FetchAverage extends _$FetchAverage {
  @override
  Future<double> build() async {
    final snap = await FirebaseFirestore.instance
        .collection('aggregation')
        .aggregate(average('value'))
        .get();

    return snap.getAverage('value') ?? 0.0;
  }
}
