import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../extensions/context_extension.dart';
import '../../../model/use_cases/sample/local_counter.dart';
import '../../../presentation/widgets/button.dart';

class LocalCounterPage extends HookConsumerWidget {
  const LocalCounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = useState(0);

    useEffect(() {
      Future(() async {
        counter.value = await ref.read(fetchLocalCounterProvider).call();
      });
      return null;
    }, const []);

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
            counter.value.toString(),
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
                    onPressed: () async {
                      final value = max(counter.value - 1, 0);
                      await ref.read(saveLocalCounter).call(value);
                      counter.value = value;
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
                    onPressed: () async {
                      final value = counter.value + 1;
                      await ref.read(saveLocalCounter).call(value);
                      counter.value = value;
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
