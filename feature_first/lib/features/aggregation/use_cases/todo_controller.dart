import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app_template/features/aggregation/use_cases/fetch_count.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_controller.g.dart';

@riverpod
class TodoController extends _$TodoController {
  @override
  Future<List<int>> build() async {
    final snap =
        await FirebaseFirestore.instance.collection('aggregation').get();
    return snap.docs
        .map((e) => e.data()['value'] as int?)
        .whereType<int>()
        .toList();
  }

  Future<void> add() async {
    final id = DateTime.now().millisecondsSinceEpoch.toString();
    final value = Random().nextInt(10);
    await FirebaseFirestore.instance.collection('aggregation').doc(id).set({
      'value': value,
      'createdAt': FieldValue.serverTimestamp(),
    });
    ref
      ..invalidateSelf()
      ..invalidate(fetchCountProvider);
  }
}
