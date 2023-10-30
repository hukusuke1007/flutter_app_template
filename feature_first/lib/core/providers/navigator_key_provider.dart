import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// NavigatorState
final navigatorKeyProvider = Provider((_) => GlobalKey<NavigatorState>());
