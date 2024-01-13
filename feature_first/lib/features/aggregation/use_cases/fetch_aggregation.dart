import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fetch_aggregation.g.dart';

typedef Result = ({int count, double sum, double average});

@riverpod
class FetchAggregation extends _$FetchAggregation {
  @override
  Future<Result> build() async {
    final snap = await FirebaseFirestore.instance
        .collection('aggregation')
        .aggregate(
          count(),
          sum('value'),
          average('value'),
        )
        .get();

    return (
      count: snap.count ?? 0,
      sum: snap.getAverage('value') ?? 0.0,
      average: snap.getSum('value') ?? 0.0
    );
  }
}
