import 'package:flutter/material.dart';
import 'package:flutter_app_template/features/aggregation/use_cases/fetch_count.dart';
import 'package:flutter_app_template/features/aggregation/use_cases/todo_controller.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/extensions/context_extension.dart';
import '../../app_wrapper/pages/main_page.dart';

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
    final items = ref.watch(todoControllerProvider).asData?.value ?? [];
    final count = ref.watch(fetchCountProvider).asData?.value;

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
                    style: TextStyle(
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                'count: $count',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        Center(
          child: FilledButton(
            onPressed: () async {
              await ref.read(todoControllerProvider.notifier).add();
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
