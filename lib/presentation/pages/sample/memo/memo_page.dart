import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../extensions/context_extension.dart';
import '../../../../extensions/scroll_controller_extension.dart';
import '../../../../utils/provider.dart';
import '../../../custom_hooks/use_effect_once.dart';
import 'memo_async_notifier_page.dart';
import 'memo_state_notifier_page.dart';

class MemoPage extends HookConsumerWidget {
  const MemoPage({super.key});

  static String get pageName => 'memo';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final tabTapOperation = ref.watch(tabTapOperationProviders(pageName));

    useEffectOnce(() {
      /// 同じタブが選択された場合、上にスクロールする
      tabTapOperation.addListener((value) {
        if (value == TabTapOperationType.duplication) {
          scrollController.animateToTop();
        }
      });
      return null;
    });

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
