import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_template/features/aggregation/use_cases/fetch_aggregation.dart';
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

  static final errorProvider = Provider<Object?>((ref) {
    final itemsAsyncValue = ref.watch(aggregationControllerProvider);
    final countAsyncValue = ref.watch(fetchCountProvider);
    final sumAsyncValue = ref.watch(fetchSumProvider);
    final averageAsyncValue = ref.watch(fetchAverageProvider);
    return itemsAsyncValue.error ??
        countAsyncValue.error ??
        sumAsyncValue.error ??
        averageAsyncValue.error;
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsyncValue = ref.watch(aggregationControllerProvider);
    final countAsyncValue = ref.watch(fetchCountProvider);
    final sumAsyncValue = ref.watch(fetchSumProvider);
    final averageAsyncValue = ref.watch(fetchAverageProvider);

    final items = itemsAsyncValue.asData?.value ?? [];
    final count = countAsyncValue.asData?.value ?? 0;
    final sum = sumAsyncValue.asData?.value ?? 0;
    final average = averageAsyncValue.asData?.value ?? 0;

    ref.listen(errorProvider, (prev, next) {
      if (next != null && next is Exception) {
        showOkAlertDialog(context: context, title: next.toString());
      }
    });

    final scrollController = useScrollController();
    final statusState = useState(0);
    const statusList = [0, 1, 2];

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
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                ref
                  ..invalidate(aggregationControllerProvider)
                  ..invalidate(fetchCountProvider)
                  ..invalidate(fetchSumProvider)
                  ..invalidate(fetchAverageProvider)
                  ..invalidate(fetchAggregationProvider);
                await Future<void>.delayed(const Duration(milliseconds: 500));
              },
              child: CustomScrollView(
                controller: scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, i) {
                      final item = items[i];
                      return Center(
                        child: Text(
                          item.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      );
                    }, childCount: items.length),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
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
          ),
        ],
      ),
      persistentFooterAlignment: AlignmentDirectional.center,
      persistentFooterButtons: [
        DropdownButton(
          isDense: true,
          items: statusList
              .map(
                (e) => DropdownMenuItem<int>(
                  value: e,
                  child: Text('status: $e'),
                ),
              )
              .toList(),
          onChanged: (int? value) {
            if (value != null) {
              statusState.value = value;
            }
          },
          value: statusList[statusState.value],
          underline: const SizedBox.shrink(),
        ),
        FilledButton(
          onPressed: () async {
            await ref
                .read(aggregationControllerProvider.notifier)
                .add(statusState.value);
          },
          child: const Text(
            '追加する',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
