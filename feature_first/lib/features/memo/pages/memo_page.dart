import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../core/custom_hooks/use_effect_once.dart';
import '../../../core/custom_hooks/use_refresh_controller.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../core/extensions/exception_extension.dart';
import '../../../core/extensions/scroll_controller_extension.dart';
import '../../../core/utils/tab_tap_operation_provider.dart';
import '../../../core/widgets/smart_refresher/smart_refresher_custom.dart';
import '../use_cases/memo_controller.dart';
import 'dialogs/show_edit_memo_dialog.dart';

class MemoPage extends HookConsumerWidget {
  const MemoPage({super.key});

  static String get pageName => 'memo';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final refreshController = useRefreshController();
    final tabTapOperation = ref.watch(tabTapOperationProviders(pageName));

    final asyncValue = ref.watch(memoControllerProvider);
    final controller = ref.watch(memoControllerProvider.notifier);

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
      resizeToAvoidBottomInset: false,
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
      body: asyncValue.when(
        data: (items) {
          return SmartRefresher(
            header: const SmartRefreshHeader(),
            footer: const SmartRefreshFooter(),
            enablePullUp: true,
            scrollController: scrollController,
            controller: refreshController,
            physics: const BouncingScrollPhysics(),
            onRefresh: () {
              ref.invalidate(memoControllerProvider);
              refreshController.refreshCompleted();
            },
            onLoading: () async {
              try {
                await controller.onFetchMore();
                refreshController.loadComplete();
              } on Exception catch (e) {
                if (context.mounted) {
                  context.showSnackBar(
                    e.errorMessage,
                    backgroundColor: Colors.grey,
                  );
                }
              }
            },
            child: ListView.separated(
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
                          try {
                            await controller.onRemove(docId);
                            if (context.mounted) {
                              context.showSnackBar('削除しました');
                            }
                          } on Exception catch (e) {
                            if (context.mounted) {
                              context.showSnackBar(
                                e.errorMessage,
                                backgroundColor: Colors.grey,
                              );
                            }
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
                    title: Text(data.text ?? '', style: context.bodyStyle),
                    trailing: Text(data.dateLabel, style: context.smallStyle),
                    onTap: () {
                      showEditMemoDialog(
                        context,
                        data: data,
                        onSave: (text, _) async {
                          try {
                            await controller.onUpdate(
                              data.copyWith(text: text),
                            );
                            return null;
                          } on Exception catch (e) {
                            return e.errorMessage;
                          }
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
          );
        },
        error: (e, _) {
          return Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: Text('エラー: $e', style: context.bodyStyle),
                ),
                TextButton(
                  child: Text(
                    'リトライ',
                    style: context.bodyStyle.copyWith(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    ref.invalidate(memoControllerProvider);
                  },
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CupertinoActivityIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showEditMemoDialog(
            context,
            onSave: (text, _) async {
              try {
                await controller.onCreate(text);
                return null;
              } on Exception catch (e) {
                return e.errorMessage;
              }
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
