import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../repositories/shared_preferences/shared_preference_key.dart';
import '../../repositories/shared_preferences/shared_preference_repository.dart';

final fetchLocalCounter = Provider((ref) => FetchLocalCounter(ref.read));

class FetchLocalCounter {
  FetchLocalCounter(this._read);
  final Reader _read;

  Future<int> call() async {
    final db = _read(sharedPreferencesRepositoryProvider);
    return (await db.fetch<int>(SharedPreferencesKey.sampleLocalCounter)) ?? 0;
  }
}

final saveLocalCounter = Provider((ref) => SaveLocalCounter(ref.read));

class SaveLocalCounter {
  SaveLocalCounter(this._read);
  final Reader _read;

  Future<void> call(int value) async {
    await _read(sharedPreferencesRepositoryProvider)
        .save<int>(SharedPreferencesKey.sampleLocalCounter, value);
  }
}
