import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'remote_config_key.dart';

part 'remote_config_repository.g.dart';

@Riverpod(keepAlive: true)
RemoteConfigRepository remoteConfigRepository(Ref ref) {
  return RemoteConfigRepository(FirebaseRemoteConfig.instance);
}

class RemoteConfigRepository {
  RemoteConfigRepository(this._remoteConfig);

  final FirebaseRemoteConfig _remoteConfig;

  Stream<RemoteConfigUpdate> get onConfigUpdated =>
      _remoteConfig.onConfigUpdated;

  Future<void> configure() async {
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: kDebugMode
            ? const Duration(minutes: 5)
            : const Duration(hours: 1),
      ),
    );
    await _remoteConfig.fetchAndActivate();
  }

  Future<bool> fetchAndActivate() => _remoteConfig.fetchAndActivate();

  String getString(RemoteConfigKey value) => _remoteConfig.getString(value.key);
}
