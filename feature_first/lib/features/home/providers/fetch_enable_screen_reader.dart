import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/repositories/channel/screen_reader_repository.dart';

part 'fetch_enable_screen_reader.g.dart';

@riverpod
class FetchEnableScreenReader extends _$FetchEnableScreenReader {
  @override
  Stream<bool> build() {
    return ref.watch(screenReaderRepositoryProvider).enableStream;
  }
}
