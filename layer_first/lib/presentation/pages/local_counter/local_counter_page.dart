import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../extensions/context_extension.dart';
import '../../../model/use_cases/local_counter/local_counter.dart';
import '../../widgets/buttons/rounded_button.dart';

class LocalCounterPage extends HookConsumerWidget {
  const LocalCounterPage({super.key});

  static String get pageName => 'local_counter';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(localCounterProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ローカルカウンター',
          style: context.subtitleStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'ローカル',
            style: context.bodyStyle,
          ),
          Text(
            key: const Key('counter'),
            counter.toString(),
            style: context.titleStyle,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: RoundedButton(
                    width: 80,
                    backgroundColor: Colors.purpleAccent,
                    onTap: () async {
                      await ref.read(localCounterProvider.notifier).decrement();
                    },
                    child: const Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: RoundedButton(
                    width: 80,
                    backgroundColor: Colors.purpleAccent,
                    onTap: () async {
                      await ref.read(localCounterProvider.notifier).increment();
                    },
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
