import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app_template/presentation/custom_hooks/use_effect_once.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../extensions/context_extension.dart';
import '../../../extensions/exception_extension.dart';
import '../../../model/entities/sample/counter.dart';
import '../../../model/use_cases/sample/firestore_counter.dart';
import '../../../presentation/widgets/rounded_button.dart';
import '../../../utils/logger.dart';

class FirestoreCounterPage extends HookConsumerWidget {
  const FirestoreCounterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = useState<Counter?>(null);
    final isLoading = useState<bool>(false);
    final counterFromStream = ref.watch(fetchFirestoreCounterStreamProvider);

    useEffectOnce(() {
      Future(() async {
        isLoading.value = true;
        try {
          counter.value = await ref.read(fetchFirestoreCounterProvider).call();
        } on Exception catch (e) {
          logger.shout(e);
          context.showSnackBar(
            e.errorMessage,
            backgroundColor: Colors.grey,
          );
        }
        isLoading.value = false;
      });
      return null;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Firestoreカウンター',
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
            'Firestore',
            style: context.bodyStyle,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8).copyWith(bottom: 32),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        (counter.value?.count ?? 0).toString(),
                        style: context.titleStyle,
                      ),
                      Text(
                        'リスナー未使用',
                        style: context.smallStyle,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        (counterFromStream.value?.count ?? 0).toString(),
                        style: context.titleStyle,
                      ),
                      Text(
                        'リスナー使用',
                        style: context.smallStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
                      if (isLoading.value) {
                        return;
                      }
                      isLoading.value = true;
                      try {
                        final newCounter = () {
                          final value = counter.value ?? const Counter();
                          final count = value.count ?? 0;
                          return value.copyWith(count: max(count - 1, 0));
                        }();
                        await ref
                            .read(saveFirestoreCounterProvider)
                            .call(newCounter);
                        final now = DateTime.now();
                        counter.value = newCounter.copyWith(
                          createdAt: counter.value?.createdAt ?? now,
                          updatedAt: now,
                        );
                      } on Exception catch (e) {
                        logger.shout(e);
                        context.showSnackBar(
                          e.errorMessage,
                          backgroundColor: Colors.grey,
                        );
                      }
                      isLoading.value = false;
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
                      if (isLoading.value) {
                        return;
                      }
                      isLoading.value = true;
                      try {
                        final newCounter = () {
                          final now = DateTime.now();
                          final value =
                              counter.value?.copyWith(updatedAt: now) ??
                                  Counter(createdAt: now, updatedAt: now);
                          final count = value.count ?? 0;
                          return value.copyWith(count: count + 1);
                        }();
                        await ref
                            .read(saveFirestoreCounterProvider)
                            .call(newCounter);
                        counter.value = newCounter;
                      } on Exception catch (e) {
                        logger.shout(e);
                        context.showSnackBar(
                          e.errorMessage,
                          backgroundColor: Colors.grey,
                        );
                      }
                      isLoading.value = false;
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
