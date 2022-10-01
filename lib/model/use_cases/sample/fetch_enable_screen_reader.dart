import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../utils/logger.dart';
import '../../repositories/channel/screen_reader_repository.dart';

final fetchEnableScreenReaderProvider =
    StateNotifierProvider<FetchEnableScreenReader, bool>(
  FetchEnableScreenReader.new,
);

class FetchEnableScreenReader extends StateNotifier<bool> {
  FetchEnableScreenReader(this._ref) : super(false) {
    _disposer =
        _ref.read(screenReaderRepositoryProvider).enableStream.listen((event) {
      /// iOSの場合、1回の設定で通知が複数回飛んでくるためそれの対策
      if (mounted && state != event) {
        logger.info(event);
        state = event;
      }
    });

    Future(() async {
      state = await call();
    });
  }

  final Ref _ref;
  late StreamSubscription<bool> _disposer;

  @override
  void dispose() {
    _disposer.cancel();
    super.dispose();
  }

  Future<bool> call() async {
    final value = await _ref.read(screenReaderRepositoryProvider).fetchEnable();
    logger.info(value);
    return value;
  }
}
