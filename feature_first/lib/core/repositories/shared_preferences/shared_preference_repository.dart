import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'shared_preference_key.dart';

part 'shared_preference_repository.g.dart';

@Riverpod(keepAlive: true)
SharedPreferencesRepository sharedPreferencesRepository(Ref ref) {
  throw UnimplementedError();
}

class SharedPreferencesRepository {
  SharedPreferencesRepository(this._prefs);

  final SharedPreferencesWithCache _prefs;

  Future<void> save<T>(SharedPreferencesKey key, T value) {
    if (value is int) {
      return _prefs.setInt(key.value, value);
    }
    if (value is double) {
      return _prefs.setDouble(key.value, value);
    }
    if (value is bool) {
      return _prefs.setBool(key.value, value);
    }
    if (value is String) {
      return _prefs.setString(key.value, value);
    }
    if (value is List<String>) {
      return _prefs.setStringList(key.value, value);
    }
    throw UnsupportedError('Not support \'$value\'');
  }

  T? fetch<T>(SharedPreferencesKey key) {
    if (T == int) {
      return _prefs.getInt(key.value) as T?;
    }
    if (T == double) {
      return _prefs.getDouble(key.value) as T?;
    }
    if (T == bool) {
      return _prefs.getBool(key.value) as T?;
    }
    if (T == String) {
      return _prefs.getString(key.value) as T?;
    }
    if (T == List<String>) {
      return _prefs.getStringList(key.value) as T?;
    }
    throw UnsupportedError('Not support \'$T\'');
  }

  Future<void> remove(SharedPreferencesKey key) => _prefs.remove(key.value);
}
