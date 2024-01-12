import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/extensions/context_extension.dart';
import '../../../core/extensions/double_extension.dart';
import '../../app_wrapper/pages/main_page.dart';
import '../use_cases/aggregation_controller.dart';
import '../use_cases/fetch_average.dart';
import '../use_cases/fetch_count.dart';
import '../use_cases/fetch_sum.dart';

class FirestoreAggregationPage extends HookConsumerWidget {
  const FirestoreAggregationPage({super.key});

  static String get pageName => 'firestore_aggregation_page';
  static String get pagePath => '${MainPage.pagePath}/$pageName';

  static void push(BuildContext context) {
    context.push(pagePath);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final items = ref.watch(aggregationControllerProvider).asData?.value ?? [];
    final count = ref.watch(fetchCountProvider).asData?.value ?? 0;
    final sum = ref.watch(fetchSumProvider).asData?.value ?? 0;
    final average = ref.watch(fetchAverageProvider).asData?.value ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Firestore Aggregation',
          style: context.subtitleStyle.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) {
                final item = items[i];
                return Center(
                  child: Text(
                    item.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
              childCount: items.length,
            ),
          ),
        ],
      ),
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              child: Text(
                'count: $count',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Flexible(
              child: Text(
                'sum: $sum',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Flexible(
              child: Text(
                'average: ${average.roundWithDigit(3)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        Center(
          child: FilledButton(
            onPressed: () async {
              await ref.read(aggregationControllerProvider.notifier).add();
            },
            child: const Text(
              '追加する',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
