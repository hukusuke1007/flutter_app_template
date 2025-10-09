import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/utils/logger.dart';

part 'screen_reader_repository.g.dart';

@Riverpod(keepAlive: true)
ScreenReaderRepository screenReaderRepository(Ref ref) {
  // TODO(shohei): prefixNameを変更した場合はiOSとAndroidのネイティブ側の変更も必要
  const prefixName = 'com.example.app';
  return ScreenReaderRepository(
    const MethodChannel('$prefixName/method/screenReader'),
    const EventChannel('$prefixName/event/screenReader/fetchEnable'),
  );
}

class ScreenReaderRepository {
  ScreenReaderRepository(this._channel, this._fetchEnableEventChannel);

  final MethodChannel _channel;
  final EventChannel _fetchEnableEventChannel;

  Future<bool> fetchEnable() async {
    try {
      final value = await _channel.invokeMethod<bool>('fetchEnable');
      return value ?? false;
    } on PlatformException catch (e) {
      logger.shout(e.toString());
      return false;
    }
  }

  Stream<bool> get enableStream => _fetchEnableEventChannel
      .receiveBroadcastStream()
      .map((dynamic event) => event as bool);
}
