import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bundle_repository.g.dart';

@Riverpod(keepAlive: true)
BundleRepository bundleRepository(Ref ref) {
  return BundleRepository(rootBundle);
}

class BundleRepository {
  BundleRepository(this._bundle);

  final AssetBundle _bundle;

  Future<Map<String, dynamic>?> fetch(String filename) async {
    final data = await _bundle.loadString(filename);
    return jsonDecode(data) as Map<String, dynamic>?;
  }
}
