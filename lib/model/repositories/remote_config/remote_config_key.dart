enum RemoteConfigKey {
  iOSAppVersion(key: 'ios_app_version'),
  androidAppVersion(key: 'android_app_version'),
  ;

  const RemoteConfigKey({
    required this.key,
  });

  final String key;
}
