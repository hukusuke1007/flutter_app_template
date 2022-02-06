import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../extensions/context_extension.dart';
import '../../../extensions/exception_extension.dart';
import '../../../model/entities/sample/counter.dart';
import '../../../model/use_cases/sample/firestore_counter.dart';
import '../../../presentation/widgets/button.dart';
import '../../../utils/logger.dart';

class FirestoreCounterPage extends HookConsumerWidget {
  const FirestoreCounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = useState<Counter?>(null);
    final isLoading = useState<bool>(false);

    useEffect(() {
      Future(() async {
        isLoading.value = true;
        try {
          counter.value = await ref.read(fetchFirestoreCounter).call();
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
    }, const []);

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
          Text(
            (counter.value?.count ?? 0).toString(),
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
                          return value.copyWith(count: max(count - 1, 0));
                        }();
                        await ref.read(saveFirestoreCounter).call(newCounter);
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
                const SizedBox(width: 16),
                Flexible(
                  child: RoundedButton(
                    width: 80,
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () async {
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
                        await ref.read(saveFirestoreCounter).call(newCounter);
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
