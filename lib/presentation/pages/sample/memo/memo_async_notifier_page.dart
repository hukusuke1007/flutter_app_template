import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../../../../extensions/context_extension.dart';
import '../../../../model/use_cases/sample/memo/async_notifier/memo_controller.dart';
import '../../../custom_hooks/use_refresh_controller.dart';
import '../../../widgets/smart_refresher/smart_refresher_custom.dart';
import '../../main/main_page.dart';
import 'show_edit_memo_dialog.dart';

class MemoAsyncNotifierPage extends HookConsumerWidget {
  const MemoAsyncNotifierPage({super.key});

  static String get pageName => 'memo_async_notifier';
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
        builder: (_) => const MemoAsyncNotifierPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(memoProvider);
    final scrollController = useScrollController();

    final refreshController = useRefreshController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'メモ AsyncNotifier',
          style: context.bodyStyle.copyWith(
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
              ref.invalidate(memoProvider);
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
                          final errorMessage = await ref
                              .read(memoProvider.notifier)
                              .onRemove(docId);
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
          );
        },
        error: (e, __) {
          return Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: Text(
                    'エラー: $e',
                    style: context.bodyStyle,
                  ),
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
                    ref.invalidate(memoProvider);
                  },
                ),
              ],
            ),
          );
        },
        loading: () => const Center(
          child: CupertinoActivityIndicator(),
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
