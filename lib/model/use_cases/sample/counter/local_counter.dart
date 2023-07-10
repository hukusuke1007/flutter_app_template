import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../repositories/shared_preferences/shared_preference_key.dart';
import '../../../repositories/shared_preferences/shared_preference_repository.dart';

final localCounterProvider = StateNotifierProvider<LocalCounter, int>(
  (ref) {
    final value = (ref
            .read(sharedPreferencesRepositoryProvider)
            .fetch<int>(LocalCounter.localCounterKey)) ??
        0;
    return LocalCounter(ref, value);
  },
);

class LocalCounter extends StateNotifier<int> {
  LocalCounter(this._ref, int defaultValue) : super(defaultValue);

  static SharedPreferencesKey get localCounterKey =>
      SharedPreferencesKey.sampleLocalCounter;

  final Ref _ref;

  Future<void> increment() async {
    state += 1;
    await _ref
        .read(sharedPreferencesRepositoryProvider)
        .save<int>(localCounterKey, state);
  }

  Future<void> decrement() async {
    state -= 1;
    await _ref
        .read(sharedPreferencesRepositoryProvider)
        .save<int>(localCounterKey, state);
  }
}
