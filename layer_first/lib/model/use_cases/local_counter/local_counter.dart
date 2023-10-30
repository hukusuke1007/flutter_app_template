import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../repositories/shared_preferences/shared_preference_key.dart';
import '../../repositories/shared_preferences/shared_preference_repository.dart';

part 'local_counter.g.dart';

@Riverpod(keepAlive: true)
class LocalCounter extends _$LocalCounter {
  @override
  int build() {
    final value = (ref
            .watch(sharedPreferencesRepositoryProvider)
            .fetch<int>(LocalCounter.localCounterKey)) ??
        0;
    return value;
  }

  static SharedPreferencesKey get localCounterKey =>
      SharedPreferencesKey.localCounter;

  Future<void> increment() async {
    state += 1;
    await ref
        .read(sharedPreferencesRepositoryProvider)
        .save<int>(localCounterKey, state);
  }

  Future<void> decrement() async {
    state -= 1;
    await ref
        .read(sharedPreferencesRepositoryProvider)
        .save<int>(localCounterKey, state);
  }
}
