import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

typedef HashCode = int;

final scrollControllerProviders =
    AutoDisposeProviderFamily<ScrollController, HashCode>((ref, _) {
      final scrollController = ScrollController();
      ref.onDispose(scrollController.dispose);
      return scrollController;
    });
