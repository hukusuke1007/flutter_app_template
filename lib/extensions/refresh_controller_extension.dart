import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

extension RefreshControllerExtension on RefreshController {
  Future<void> loadDelayComplete(ScrollController scrollController) async {
    /// これで一旦試す
    if (scrollController.hasClients) {
      await scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 100),
        curve: Curves.ease,
      );
    }
    loadComplete();
  }
}
