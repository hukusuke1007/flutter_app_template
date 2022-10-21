import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../extensions/context_extension.dart';
import '../../../../model/use_cases/sample/memo/memo_controller.dart';
import '../../../custom_hooks/use_effect_once.dart';
import '../../../custom_hooks/use_refresh_controller.dart';
import '../../../widgets/smart_refresher_custom.dart';
import 'show_edit_memo_dialog.dart';

class MemoStateNotifierPage extends HookConsumerWidget {
  const MemoStateNotifierPage({super.key});

  static Future<void> show(BuildContext context) {
    return Navigator.of(context).push<void>(
      CupertinoPageRoute(
        builder: (_) => const MemoStateNotifierPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(memoProvider);
    final scrollController = useScrollController();
    final refreshController = useRefreshController();

    useEffectOnce(() {
      Future(() async {
        final errorMessage = await ref.read(memoProvider.notifier).onFetch();
        if (errorMessage != null) {
          context.showSnackBar(
            errorMessage,
            backgroundColor: Colors.grey,
          );
        }
      });
      return null;
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'メモ StateNotifier',
          style: context.bodyStyle.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SmartRefresher(
        header: const SmartRefreshHeader(),
        footer: const SmartRefreshFooter(),
        // ignore: avoid_redundant_argument_values
        enablePullDown: true,
        enablePullUp: true,
        controller: refreshController,
        physics: const BouncingScrollPhysics(),
        onRefresh: () async {
          final errorMessage = await ref.read(memoProvider.notifier).onFetch();
          if (errorMessage != null) {
            context.showSnackBar(
              errorMessage,
              backgroundColor: Colors.grey,
            );
          }
          refreshController.refreshCompleted();
        },
        onLoading: () async {
          final errorMessage =
              await ref.read(memoProvider.notifier).onFetchMore();
          if (errorMessage != null) {
            context.showSnackBar(
              errorMessage,
              backgroundColor: Colors.grey,
            );
          }
          refreshController.loadComplete();
        },
        child: ListView.separated(
          controller: scrollController,
          itemBuilder: (BuildContext context, int index) {
            final data = items[index];
            return Slidable(
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (_) async {
                      final docId = data.memoId;
                      if (docId == null) {
                        return;
                      }
                      final alertResult = await showOkCancelAlertDialog(
                        context: context,
                        title: '削除しますか？',
                      );
                      if (alertResult == OkCancelResult.cancel) {
                        return;
                      }
                      final errorMessage =
                          await ref.read(memoProvider.notifier).onRemove(docId);
                      if (errorMessage != null) {
                        context.showSnackBar(
                          errorMessage,
                          backgroundColor: Colors.grey,
                        );
                      } else {
                        context.showSnackBar('削除しました');
                      }
                    },
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: '削除',
                  ),
                ],
              ),
              child: ListTile(
                title: Text(
                  data.text ?? '',
                  style: context.bodyStyle,
                ),
                trailing: Text(
                  data.dateLabel,
                  style: context.smallStyle,
                ),
                onTap: () {
                  showEditMemoDialog(
                    context,
                    data: data,
                    onSave: (text, _) async {
                      final errorMessage = await ref
                          .read(memoProvider.notifier)
                          .onUpdate(data.copyWith(text: text));
                      return errorMessage;
                    },
                  );
                },
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(height: 1);
          },
          itemCount: items.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showEditMemoDialog(
            context,
            onSave: (text, _) async {
              final errorMessage =
                  await ref.read(memoProvider.notifier).onCreate(text);
              return errorMessage;
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
