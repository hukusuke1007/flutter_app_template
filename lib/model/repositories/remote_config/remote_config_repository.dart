import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'remote_config_key.dart';

final remoteConfigRepositoryProvider = Provider<RemoteConfigRepository>(
  (_) => RemoteConfigRepository(FirebaseRemoteConfig.instance),
);

class RemoteConfigRepository {
  RemoteConfigRepository(this._remoteConfig);

  final FirebaseRemoteConfig _remoteConfig;

  Stream<RemoteConfigUpdate> get onConfigUpdated =>
      _remoteConfig.onConfigUpdated;

  Future<void> configure() async {
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval:
            kDebugMode ? const Duration(minutes: 5) : const Duration(hours: 1),
      ),
    );
    await _remoteConfig.fetchAndActivate();
  }

  Future<bool> fetchAndActivate() => _remoteConfig.fetchAndActivate();

  String getString(RemoteConfigKey value) => _remoteConfig.getString(value.key);
}
