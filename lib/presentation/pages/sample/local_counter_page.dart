import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../extensions/context_extension.dart';
import '../../../model/use_cases/sample/local_counter.dart';
import '../../../presentation/widgets/rounded_button.dart';
import '../../custom_hooks/use_effect_once.dart';

class LocalCounterPage extends HookConsumerWidget {
  const LocalCounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(localCounterProvider);

    useEffectOnce(() {
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        ref.read(localCounterProvider.notifier).fetch();
      });
      return null;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ローカルカウンター',
          style: context.subtitleStyle.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'ローカル',
            style: context.bodyStyle,
          ),
          Text(
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
                    child: const Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                    onTap: () async {
                      await ref.read(localCounterProvider.notifier).decrement();
                      // counter.value = value;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: RoundedButton(
                    width: 80,
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onTap: () async {
                      await ref.read(localCounterProvider.notifier).increment();
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
