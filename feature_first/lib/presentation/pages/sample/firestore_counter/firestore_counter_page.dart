import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../extensions/context_extension.dart';
import '../../../../model/use_cases/sample/counter/fetch_firestore_counter_stream.dart';
import '../../../../model/use_cases/sample/counter/firestore_counter.dart';
import '../../../widgets/buttons/rounded_button.dart';
import '../../main/main_page.dart';

class FirestoreCounterPage extends HookConsumerWidget {
  const FirestoreCounterPage({super.key});

  static String get pageName => 'firestore_counter';
  static String get pagePath => '${MainPage.pagePath}/$pageName';

  /// go_routerの画面遷移
  static void push(BuildContext context) {
    context.push(pagePath);
  }

  /// 従来の画面遷移
  static Future<void> showNav1(BuildContext context) {
    return Navigator.of(context, rootNavigator: true).push<void>(
      CupertinoPageRoute(
        settings: RouteSettings(name: pageName),
        builder: (_) => const FirestoreCounterPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counterAsyncValue = ref.watch(firestoreCounterProvider);
    final counter = counterAsyncValue.asData?.value;
    final counterFromStream = ref.watch(fetchFirestoreCounterProvider);

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
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
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
                        (counter?.count ?? 0).toString(),
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
                      await ref
                          .read(firestoreCounterProvider.notifier)
                          .save(-1);
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
                      await ref.read(firestoreCounterProvider.notifier).save(1);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      persistentFooterButtons: counterAsyncValue.error != null
          ? [
              Center(
                child: Text(
                  counterAsyncValue.error?.toString() ?? '',
                  style: context.bodyStyle.copyWith(
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ]
          : null,
    );
  }
}
