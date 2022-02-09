import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final bundleRepositoryProvider = Provider((_) => BundleRepository(rootBundle));

class BundleRepository {
  BundleRepository(this._bundle);

  final AssetBundle _bundle;

  Future<Map<String, dynamic>?> fetch(String filename) async {
    final data = await _bundle.loadString(filename);
    return jsonDecode(data) as Map<String, dynamic>?;
  }
}
