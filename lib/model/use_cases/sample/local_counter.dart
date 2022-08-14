import 'dart:math';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../repositories/shared_preferences/shared_preference_key.dart';
import '../../repositories/shared_preferences/shared_preference_repository.dart';

final localCounterProvider =
    StateNotifierProvider<LocalCounter, int>((ref) => LocalCounter(ref.read));

class LocalCounter extends StateNotifier<int> {
  LocalCounter(this._read) : super(0) {
    fetch();
  }

  static SharedPreferencesKey get localCounterKey =>
      SharedPreferencesKey.sampleLocalCounter;

  final Reader _read;

  void fetch() {
    final db = _read(sharedPreferencesRepositoryProvider);
    state = (db.fetch<int>(localCounterKey)) ?? 0;
  }

  Future<void> increment() async {
    state += 1;
    await _read(sharedPreferencesRepositoryProvider)
        .save<int>(localCounterKey, state);
  }

  Future<void> decrement() async {
    state = max(state - 1, 0);
    await _read(sharedPreferencesRepositoryProvider)
        .save<int>(localCounterKey, state);
  }
}
