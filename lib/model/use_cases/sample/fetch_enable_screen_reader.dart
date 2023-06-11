import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../repositories/channel/screen_reader_repository.dart';

final fetchEnableScreenReaderProvider =
    StreamNotifierProvider.autoDispose<FetchEnableScreenReader, bool>(
  FetchEnableScreenReader.new,
);

class FetchEnableScreenReader extends AutoDisposeStreamNotifier<bool> {
  @override
  Stream<bool> build() {
    return ref.read(screenReaderRepositoryProvider).enableStream;
  }
}
