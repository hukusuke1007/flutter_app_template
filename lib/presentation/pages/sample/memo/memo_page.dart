import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../extensions/context_extension.dart';
import '../../../../utils/provider.dart';
import 'memo_async_notifier_page.dart';
import 'memo_state_notifier_page.dart';

class MemoPage extends HookConsumerWidget {
  const MemoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = ref.watch(scrollControllerProviders(hashCode));
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'メモ',
          style: context.subtitleStyle.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Scrollbar(
        controller: scrollController,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              ListTile(
                title: Text(
                  'StateNotifierのサンプル',
                  style:
                      context.bodyStyle.copyWith(fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                ),
                onTap: () {
                  MemoStateNotifierPage.push(context);
                },
              ),
              const Divider(height: 1),
              ListTile(
                title: Text(
                  'AsyncNotifierのサンプル',
                  style:
                      context.bodyStyle.copyWith(fontWeight: FontWeight.bold),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                ),
                onTap: () {
                  MemoAsyncNotifierPage.push(context);
                },
              ),
              const Divider(height: 1),
            ],
          ),
        ),
      ),
    );
  }
}
